Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266302AbUAHVOI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 16:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266305AbUAHVOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 16:14:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8198 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S266302AbUAHVOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 16:14:05 -0500
Message-ID: <3FFDC7F4.4070800@zytor.com>
Date: Thu, 08 Jan 2004 13:13:24 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: trond.myklebust@fys.uio.no
CC: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org,
       raven@themaw.net, Michael.Waychison@sun.com, thockin@sun.com
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
References: <33128.141.211.133.197.1073590355.squirrel@webmail.uio.no>        <3FFDB272.8030808@zytor.com> <33178.141.211.133.197.1073592524.squirrel@webmail.uio.no>
In-Reply-To: <33178.141.211.133.197.1073592524.squirrel@webmail.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

trond.myklebust@fys.uio.no wrote:
> 
> My point is that the above problem crops up in almost *all* combinations
> of automounter daemon with remote filesystem and strong authentication.
> In order to correctly mount the remote filesystem, the automounter
> itself needs a minimum set of remote privileges (typically it needs to be
> able to browse the remote filesystem).
> 
> RFC-2623 describes how to add RPCSEC_GSS to NFSv2/v3. The
> workarounds (hacks really) that I refer to above had to be deliberately
> added in order to make Sun's automounter work in this environment.
> The alternative would have been to have a global "machine" credential
> for use by the automounter when browsing /net. Hardly secure...
> 

My point is that it's what you get for having an automounter.

We can't solve Sun's designed-in braindamage, unfortunately.  This is
partially why I'd like people to consider the scope of what automounting
does; there are tons of policy issues not all of which are going to be
appropriate in all contexts.  To some degree, if you have to have an
automounter you have already lost.

Also, your global machine credential is to some degree "all the security
you get."  Any security which isn't enforced by the filesystem driver
doesn't exist in a Unix environment; in particular there is no security
against root.  Stupid tricks like remapping uid 0 are just that; stupid
tricks without any real security value.  You know this, of course.
However, if you think the automounter doesn't have the privilege to
access the remote server but the user does, then that's false security.

Linux at this point has no ability to support actual user-mounted
filesystems.  There are things that could be done to remedy this, but it
would require massive changes to every filesystem driver as well as to
the VFS.  Would it be desirable?  Absolutely.  However, it's partially
the quagmire that got the HURD stuck for a very long time, even though
they had the huge advantage of being able to run their filesystem
drivers in a nonprivileged context.

	-hpa

