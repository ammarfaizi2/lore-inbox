Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbVHMArO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbVHMArO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 20:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbVHMArO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 20:47:14 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:47116 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750836AbVHMArO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 20:47:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UCAFAlXPf94PKKnzxcYKOrS+E3nGytdCWeyamWor51kWkxUJXRzRDuq+vi7OJQm2TXdPfCaW8e4vriaE5kxgb5Cr4C13pAPzE2lORTAmniIIqxSjW1mN3QedsJnz/uwPTHLasA6jRqw+hgu9AY67jxbaMOzh3dZMEZk/Tok7CyQ=
Message-ID: <bda6d13a050812174768154ea5@mail.gmail.com>
Date: Fri, 12 Aug 2005 17:47:11 -0700
From: Joshua Hudson <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: BSD jail
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had been wanting this functionality myself, but for some reason it never found
its way into the stock kernel.  I looked around, started coding,
looked some more,
coded some more, looked some more until I found this:

http://kerneltrap.org/node/3823

I suppose the reason it wasn't applied is lack of good IPv6 support.

It is perhaps about what I was looking for, but a slightly different method.
My idea was to cause no disturbance to the normal security chain, and
so maintain jails in the following manner (remember, the sys_jail call
is trusted)
 1. Add an additional check to path_lookup (actually, a functioned
called by path_lookup)
to check for jail roots in addition to normal chroots.
 2. Lockdown process visibility to only processes in the same jail.
 3. Lockdown kill/ptrace/setpriority to processes in the same jail.
 4. Lockdown capabilities to a restricted set that prevents novel
means of breaking the jail.
 5. Restrict binding to one IPv4 and one IPv6 address (squash bind to
all to bind to that).
All of this is done in front of the normal security mechansim, so that
some non-default
security module will not accidentally break this.

I provided compatability for exactly the BSD jail(2) call, but did it
without breaking
programs that depend on chroot escapes working (there are a few).

I am currently about a third of the way to completion. This means that
I will finish
unless some other mechanism is provided before I do. I personally
don't care if my
patch is used (if released), but I want this functionality.
