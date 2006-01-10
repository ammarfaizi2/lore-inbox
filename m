Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWAJMCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWAJMCD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 07:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWAJMCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 07:02:03 -0500
Received: from boogie.lpds.sztaki.hu ([193.225.12.226]:42983 "EHLO
	boogie.lpds.sztaki.hu") by vger.kernel.org with ESMTP
	id S1750762AbWAJMCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 07:02:02 -0500
Date: Tue, 10 Jan 2006 13:01:52 +0100
From: Gabor Gombas <gombasg@sztaki.hu>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andreas Gruenbacher <agruen@suse.de>,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 0/2] Tmpfs acls
Message-ID: <20060110120152.GA27480@boogie.lpds.sztaki.hu>
References: <200601090023.16956.agruen@suse.de> <E1Evk3m-00043Y-00@chiark.greenend.org.uk> <200601100059.47317.agruen@suse.de> <20060110000758.GA22399@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110000758.GA22399@srcf.ucam.org>
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 12:07:58AM +0000, Matthew Garrett wrote:

> Handwavy problem scenario - user A logs in, is given access to the 
> soundcard. Starts running a program that when given appropriate signals 
> will record from the system microphone. Logs out. Waits for user B, who 
> he suspects is having an affair with his wife, and then monitors any 
> conversations that user B has. ACLs on their own don't seem to solve 
> this any more than just statically assigning group membership to users.

This scenario is not a permission but a locking problem. User B should
just claim the microphone exclusively and that should fail if user A
keeps an fd open.

For the generic case maybe a new lock type would be useful, that would
fail iff a process with a different effective UID keeps the device open.

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------
