Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965100AbVITTkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbVITTkL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 15:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbVITTkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 15:40:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60090 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965100AbVITTkJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 15:40:09 -0400
Date: Tue, 20 Sep 2005 12:39:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: John McCutchan <ttb@tentacle.dhs.org>
cc: Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event under
 load
In-Reply-To: <C6EA1BFF-119D-440D-81C0-3E1BC977A4B0@tentacle.dhs.org>
Message-ID: <Pine.LNX.4.58.0509201237550.2553@g5.osdl.org>
References: <1127188015.17794.6.camel@vertex> <Pine.LNX.4.58.0509192054060.2553@g5.osdl.org>
 <20050920042456.GC7992@ftp.linux.org.uk> <1127190971.18595.5.camel@vertex>
 <20050920044623.GD7992@ftp.linux.org.uk> <1127191992.19093.3.camel@vertex>
 <20050920045835.GE7992@ftp.linux.org.uk> <1127192784.19093.7.camel@vertex>
 <20050920051729.GF7992@ftp.linux.org.uk> <76677C3D-D5E0-4B5A-800F-9503DA09F1C3@tentacle.dhs.org>
 <20050920163848.GO7992@ftp.linux.org.uk> <C6EA1BFF-119D-440D-81C0-3E1BC977A4B0@tentacle.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Sep 2005, John McCutchan wrote:
> 
> Okay here are some cases to help you get a better idea,

The case that is _interesting_ is this one:

 ln /tmp/foo /tmp/bar

 p1: watch /tmp/foo

and then one or both of (different orders - four cases):

 p2: rm /tmp/bar
 p2: rm /tmp/foo

(along with "fd = open(/tmp/foo) + rm /tmp/foo + sleep + close(fd)" of 
course, which Al already pointed out).

		Linus
