Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267179AbTCEPZ7>; Wed, 5 Mar 2003 10:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267180AbTCEPZ7>; Wed, 5 Mar 2003 10:25:59 -0500
Received: from air-2.osdl.org ([65.172.181.6]:61084 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267179AbTCEPZ4>;
	Wed, 5 Mar 2003 10:25:56 -0500
Date: Wed, 5 Mar 2003 07:34:37 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: kraxel@bytesex.org, linux-kernel@vger.kernel.org
Subject: Re: reducing stack usage in v4l?
Message-Id: <20030305073437.0673458e.rddunlap@osdl.org>
In-Reply-To: <20030305093534.A8883@flint.arm.linux.org.uk>
References: <32833.4.64.238.61.1046841945.squirrel@www.osdl.org>
	<87u1eigomv.fsf@bytesex.org>
	<20030305093534.A8883@flint.arm.linux.org.uk>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Mar 2003 09:35:34 +0000
Russell King <rmk@arm.linux.org.uk> wrote:

| On Wed, Mar 05, 2003 at 10:15:52AM +0100, Gerd Knorr wrote:
| > But when looking at the disasm output it is obvious that it isn't true
| > (at least with gcc 3.2).  On the other hand it is common practice in
| > many drivers, there must be a reason for that, no?  Any chance this
| > used to work with older gcc versions?
| 
| I don't believe so - I seem to remember looking at gcc 2.95 and finding
| the same annoying behaviour.

Yes, that's what I'm seeing with 2.96 as well.

| > Not sure what is the best idea to fix that.  Don't like the kmalloc
| > idea that much.  The individual structs are not huge, the real problem
| > is that many of them are allocated and only few are needed.  Any
| > chance to tell gcc that it should allocate block-local variables at
| > the start block not at the start of the function?
| 
| Not a particularly clean idea, but maybe creating a union of the
| structures and putting that on the stack? (ie, doing what GCC should
| be doing in the first place.)

That's an idea.  Or make separate called functions for each ioctl and declare
the structures inside them?

--
~Randy


Here are some v4l structure sizes from gcc 2.96 on a P4:

sizeof video_audio: 40
sizeof video_buffer: 20
sizeof video_capability: 60
sizeof video_channel: 48
sizeof video_mbuf: 136
sizeof video_mmap: 16
sizeof video_picture: 14
sizeof video_tuner: 52
sizeof video_window: 32
sizeof v4l2_audio: 52
sizeof v4l2_buffer: 68
sizeof v4l2_capability: 104
sizeof v4l2_control: 8
sizeof v4l2_fmtdesc: 64
sizeof v4l2_format: 204
sizeof v4l2_framebuffer: 44
sizeof v4l2_frequency: 44
sizeof v4l2_input: 76
sizeof v4l2_queryctrl: 68
sizeof v4l2_requestbuffers: 20
sizeof v4l2_tuner: 84
