Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280879AbRKBXbz>; Fri, 2 Nov 2001 18:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280880AbRKBXbp>; Fri, 2 Nov 2001 18:31:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23306 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280879AbRKBXbh>; Fri, 2 Nov 2001 18:31:37 -0500
Subject: Re: [CHECKER] 8 probable security errors
To: kash@stanford.edu (Ken Ashcraft)
Date: Fri, 2 Nov 2001 23:38:22 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, engler@cs.stanford.edu
In-Reply-To: <Pine.GSO.4.33.0111021443080.6907-100000@saga18.Stanford.EDU> from "Ken Ashcraft" at Nov 02, 2001 03:15:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15zntH-0003x0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Start --->
> 		if (cmd.length){
> Error --->
> 			if( copy_from_user((void*)&mbox->data, u_data, cmd.length))
> 				return -EFAULT;

You have to be priviledged for this

> [BUG] tex gets copied in on line 1365.  there are a number of paths to get to this error (gem)
> /home/kash/linux/2.4.12-ac3/drivers/char/drm/radeon_state.c:1107:radeon_cp_dispatch_texture: ERROR:RANGE:1000:1107: Using user length "tex_width" as argument to "copy_from_user" [type=LOCAL] [state = need_lb] set by 'inferred by call to copy_to_user, line 1058':1000 [linkages -> 1000:tex_width=(null) -> 1000:width op (null) -> 1000:tex->width -> 1000:tex:start] [distance=82]

This one looks real. Im still waiting for answers from the DRI folks

> [BUG]3  i think so.  there is a check (dump.offset + dump.length >
> card->hw.memory)) that can be fooled with well chosen offset values.

Again firmware and privilegded

Alan
