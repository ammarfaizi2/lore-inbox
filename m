Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161149AbWGNQPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161149AbWGNQPQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 12:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161165AbWGNQPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 12:15:15 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53694 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161149AbWGNQPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 12:15:14 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <20060711075051.382004000@localhost.localdomain>
	<20060711075420.937831000@localhost.localdomain>
	<m1fyh7eb9i.fsf@ebiederm.dsl.xmission.com>
	<44B50088.1010103@fr.ibm.com>
	<m1psgaag7y.fsf@ebiederm.dsl.xmission.com>
	<20060714141728.GE28436@sergelap.austin.ibm.com>
	<6D6A2B70-5BE7-4B32-B6BF-E1AB33491A9F@mac.com>
Date: Fri, 14 Jul 2006 10:13:47 -0600
In-Reply-To: <6D6A2B70-5BE7-4B32-B6BF-E1AB33491A9F@mac.com> (Kyle Moffett's
	message of "Fri, 14 Jul 2006 11:43:24 -0400")
Message-ID: <m1k66guptw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> writes:

> On Jul 14, 2006, at 10:17:28, Serge E. Hallyn wrote:
>> Quoting Eric W. Biederman (ebiederm@xmission.com):
>>> No.  The uids in a filesystem are interpreted in some user  namespace
>>> context.  We can discover that context at the first mount of the filesystem.
>>> Assuming the uids on a filesystem are  the same set of uids your process is
>>> using is just wrong.
>>
>> But, when I insert a usb keychain disk into my laptop, that fs  assumes the
>> uids on it's fs are the same as uids on my laptop...
>>
>> Solving that problem is interesting, but may be something to work with a much
>> wider community on.  I.e. the cifs and nifs folks.  I haven't even googled to
>> see what they say about it.
>
> IMHO filesystems _and_ processes should be primary objects in a UID  namespace.
> This would make it possible to solve the usb-key problems  _and_ the
> user-mounted FUSE problems.  If "ns0" is the boot uid  namespace, then put the
> freshly mounted USB key in a new "ns1" (names  just for convenience).  All the
> user processes would continue to be  in ns0, but with the kernel keyring system
> you could create a new "uid" keytype and give the logged in user (ns0,user_uid)
> a user-key  with (ns1,0*).  If you added bits to the user-keys to represent the
> equivalent of CAP_DAC_OVERRIDE/CAP_CHOWN/etc for that process and UID
> namespace, then the user could do anything to any file on their USB  key, even
> change ownership, without disrupting the rest of the  system.  Likewise, if you
> did that for user FUSE filesystems, then suid binaries would not be able to get
> themselves into trouble in  exploitive FUSE infinitely-recursive monstrosities.

Thank you!

It is nice to see when someone else gets the point :)

I had not quite considered how that affects user mounted filesystems
but that does look like a real solution.

Now we just need to implement these things and work out the details of
user keys to map user ids.

Eric

