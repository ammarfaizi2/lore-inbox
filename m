Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264376AbUAIVC5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 16:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264359AbUAIVC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 16:02:57 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35589 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264376AbUAIVCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 16:02:54 -0500
Message-ID: <3FFF16CE.6060407@zytor.com>
Date: Fri, 09 Jan 2004 13:02:06 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Mike Waychison <Michael.Waychison@Sun.COM>
CC: trond.myklebust@fys.uio.no, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, raven@themaw.net, thockin@Sun.COM
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
References: <33128.141.211.133.197.1073590355.squirrel@webmail.uio.no> <3FFDB272.8030808@zytor.com> <33178.141.211.133.197.1073592524.squirrel@webmail.uio.no> <3FFDC7F4.4070800@zytor.com> <3FFF1101.3090804@sun.com>
In-Reply-To: <3FFF1101.3090804@sun.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Waychison wrote:
> H. Peter Anvin wrote:
> 
>> My point is that it's what you get for having an automounter.
>>
>> We can't solve Sun's designed-in braindamage, unfortunately.  This is
>> partially why I'd like people to consider the scope of what automounting
>> does; there are tons of policy issues not all of which are going to be
>> appropriate in all contexts.  To some degree, if you have to have an
>> automounter you have already lost.
>>  
> 
> However, we can solve Linux's designed-in braindamage.
> 

I was referring to the visibility of server-side mount points in NFS 2/3
and the fact that most of the uses of the automounter is to work around
this shortcoming.  This is a protocol limitation.

(Don't get me started on stuff like "plus lines" in map, which breaks
the map paradigm completely.  That's brokenness on a whole other level,
but which can be reasonably ignored.)

>> in particular there is no security
>> against root.  Stupid tricks like remapping uid 0 are just that; stupid
>> tricks without any real security value.  You know this, of course.
>> However, if you think the automounter doesn't have the privilege to
>> access the remote server but the user does, then that's false security.
>
> No, the security lies in the fact that the remote server knows the user
> is privileged to access it.  It's a side issue that the mount itself is
> made using an automounter.

Again, it doesn't matter if the user passes credentials to an
automounter or to the kernel.

>> Linux at this point has no ability to support actual user-mounted
>> filesystems.  There are things that could be done to remedy this, but it
>> would require massive changes to every filesystem driver as well as to
>> the VFS. 
> 
> ??  As part of our research into namespaces, we at Sun have gone through
> and tried to identify the number of semantic changes required to achieve
> user-privileged mounting, however we never saw the need to do anything
> special at all in 'each filesystem driver'.  The issue is one of a
> permission model and should be out of scope for individual filesystems.

It's trivial to crash most filesystem drivers (or get to a security leak
level) by feeding them deliberately bad input.  Robustness against
corruption in Linux has been with respect to likely data corruption much
more than deliberate attacks.  It's a major effort; security-auditing
every filesystem driver.

	-hpa

