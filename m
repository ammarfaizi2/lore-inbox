Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262683AbULQAzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbULQAzN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 19:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbULQAzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 19:55:12 -0500
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:25804 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262683AbULQAva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 19:51:30 -0500
Message-ID: <41C22D93.3030101@austin.rr.com>
Date: Thu, 16 Dec 2004 18:51:31 -0600
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Clark <michael@metaparadigm.com>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, cliffw@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: automated filesystem testing for multiple Linux fs
References: <41BDC9CD.60504@austin.rr.com> <20041213092057.5bf773fb.cliffw@osdl.org> <41BDE0B4.6020003@austin.rr.com> <41BDE2CF.9060402@austin.rr.com> <20041216121151.GH8246@logos.cnet> <1103215183.12201.39.camel@smfhome.smfdom> <41C2280C.1030009@metaparadigm.com>
In-Reply-To: <41C2280C.1030009@metaparadigm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Clark wrote:

> Steve French wrote:
>
>> ...  Since
>> at present only XFS and JFS have the full combination of server
>> features: better quotas, DMAPI, xattr support, ACL support and
>> nanosecond file timestamps on disk
>>
>
> Does JFS have quota support now?
>
> Last I looked it was still on the To Do list.
>
> ~mc
>
I remember them adding it four months ago or so.  Looking at 
http://linux.bkbits.net/linux-2.5
it seems to be mostly in changeset 1.1803.133.1

Now if I could only figure out a way to get the quota tools to work with 
a network filesystem :)
(NFS bypasses the kernel for quotas by hacking directly into the 
userspace tools which is no
better than the hack we have to do with the samba client utilities for 
setting quotas out of
kernel today).

It would be fairly easy for me to hook cifs into getting called from 
do_quotactl (in fs/quota.c) but that
interface only works with local filesystems that have real devices (not 
deviceless filesystems like
network and some cluster filesystems).   I find it very strange that the 
quota interface takes
a path converts it to a local device and then converts it to a 
superblock.   If only we could define
a sys call to allow deviceless filesystems to hook into the kernel quota 
interface - it looks like a small change
to create a one off of sys_quotactl.

