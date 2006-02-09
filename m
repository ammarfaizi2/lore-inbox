Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030621AbWBIFnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030621AbWBIFnZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 00:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030622AbWBIFnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 00:43:25 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58533 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030621AbWBIFnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 00:43:24 -0500
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Sam Vilain <sam@vilain.net>,
       Rik van Riel <riel@redhat.com>, Kirill Korotaev <dev@openvz.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: The issues for agreeing on a virtualization/namespaces
 implementation.
References: <43E7C65F.3050609@openvz.org>
	<m1bqxju9iu.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com>
	<43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com>
	<20060207201908.GJ6931@sergelap.austin.ibm.com>
	<43E90716.4020208@watson.ibm.com>
	<m17j86dds4.fsf_-_@ebiederm.dsl.xmission.com>
	<C7D99186-5EBF-412D-B977-963570CD914D@mac.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 08 Feb 2006 22:41:10 -0700
In-Reply-To: <C7D99186-5EBF-412D-B977-963570CD914D@mac.com> (Kyle Moffett's
 message of "Wed, 8 Feb 2006 23:45:02 -0500")
Message-ID: <m1y80l2io9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> writes:

> On Feb 07, 2006, at 17:06, Eric W. Biederman wrote:
>> I think I can boil the discussion down into some of the fundamental questions
>> that we are facing.
>>
>> Currently everyone seems to agree that we need something like my  namespace
>> concept that isolates multiple resources.
>>
>> We need these for
>> UIDS
>> FILESYSTEM
>
> I have one suggestion for this (it also covers capabilities to a  certain
> extent).  Could we use the kernel credentials system to  abstract away the
> concept of a single UID/GID?  We currently have  uid, euid, gid, egid, groups,
> fsid.  I'm thinking that there would be  virtualized UID tables to determine
> ownership of processes/SHM/etc.
>
> Each process would have a (uid_container,uid) pair (or similar) as  its "uid"
> and likewise for gid.  Then the ability to send signals to  any given
> (uid_container,uid) or (gid_container,gid) pair would be  given by keys in the
> kernel keyring indexed by the "uid_container"  part and containing the "uid"
> part (or maybe just a pointer).
>
> Likewise the filesystem access could be virtualized by using uid and  gid keys
> in the kernel keyring indexed by vfsmount (Not superblock,  so that it would be
> possible to have different UID representations on different mounts/parts of the
> same filesystem).
>
> I'm guessing that the performance implications of the above would not  be quite
> so nice, as it would put a lot of code in the fastpath, but  I would guess that
> it might be possible to use the existing fields  for processes without any
> virtualization needs.

At least for signal sending it looks like it would be easier to just compare
the pointers to struct user.  At least in that context it looks like it
would be as cheap as what we are doing now.  I just don't know where
to find a struct user for the euid, or is it the normal uid.

Eric
