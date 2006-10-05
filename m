Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWJEPg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWJEPg5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 11:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWJEPg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 11:36:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32739 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932135AbWJEPg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 11:36:56 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
References: <20061003170032.GA30036@in.ibm.com>
	<20061003172511.GL3164@in.ibm.com>
	<20061003201340.afa7bfce.akpm@osdl.org>
	<m1vemzbe4c.fsf@ebiederm.dsl.xmission.com>
	<20061004214403.e7d9f23b.akpm@osdl.org>
	<m1ejtnb893.fsf@ebiederm.dsl.xmission.com>
	<20061004233137.97451b73.akpm@osdl.org> <45252402.6010300@zytor.com>
Date: Thu, 05 Oct 2006 09:35:02 -0600
In-Reply-To: <45252402.6010300@zytor.com> (H. Peter Anvin's message of "Thu,
	05 Oct 2006 08:25:54 -0700")
Message-ID: <m1vemy3heh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Andrew Morton wrote:
>> On Thu, 05 Oct 2006 00:13:12 -0600
>> ebiederm@xmission.com (Eric W. Biederman) wrote:
>>
>>> Do things work better if you don't specify a vga=xxx mode?
>> yes, without vga=0x263 it boots.
>
> vga= actually patches a specific offset in the boot sector.  We don't actually
> have 512 bytes, we have some 500-ish bytes plus a small patch area at the end.

>From video.S
It uses offset 0 in the boot sector.  We have 497 bytes that can be used,
before we call setup.S after that setup.S considers the entire bootsector
it's own.

/* Positions of various video parameters passed to the kernel */
/* (see also include/linux/tty.h) */
#define PARAM_CURSOR_POS	0x00
#define PARAM_VIDEO_PAGE	0x04
#define PARAM_VIDEO_MODE	0x06
#define PARAM_VIDEO_COLS	0x07
#define PARAM_VIDEO_EGA_BX	0x0a
#define PARAM_VIDEO_LINES	0x0e
#define PARAM_HAVE_VGA		0x0f
#define PARAM_FONT_POINTS	0x10

#define PARAM_LFB_WIDTH		0x12
#define PARAM_LFB_HEIGHT	0x14
#define PARAM_LFB_DEPTH		0x16
#define PARAM_LFB_BASE		0x18
#define PARAM_LFB_SIZE		0x1c
#define PARAM_LFB_LINELENGTH	0x24
#define PARAM_LFB_COLORS	0x26
#define PARAM_VESAPM_SEG	0x2e
#define PARAM_VESAPM_OFF	0x30
#define PARAM_LFB_PAGES		0x32
#define PARAM_VESA_ATTRIB	0x34
#define PARAM_CAPABILITIES	0x36

Eric
