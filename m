Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267565AbUI1GX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267565AbUI1GX5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 02:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267566AbUI1GX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 02:23:57 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:10575 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267565AbUI1GXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 02:23:53 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm4 + alps locks input in X (alps not identifying correctly)
Date: Tue, 28 Sep 2004 01:23:50 -0500
User-Agent: KMail/1.6.2
Cc: Micha Feigin <michf@post.tau.ac.il>
References: <20040927192744.GA8947@luna.mooo.com> <m3wtyf792x.fsf@telia.com> <20040928034622.GA3158@luna.mooo.com>
In-Reply-To: <20040928034622.GA3158@luna.mooo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409280123.50804.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 September 2004 10:46 pm, Micha Feigin wrote:
> > Or better yet, use the auto-dev feature, which should work if you have
> > a new enough X driver and kernel patch.
> > 
> 
> auto-dev doesn't work for me and I don't have time to check it
> out.

Addition of Kensington ThinkingMouse / ExpertMouse support caused Synaptics
and ALPS protocol numbers to move to 8 and 9 respectively which broke Peter's
auto-dev detection. 

Vojtech, we need to keep protcol numbers stable, I propose something like this:

enum psmouse_type {
        PSMOUSE_PS2		= 0,
        PSMOUSE_PS2PP,
        PSMOUSE_THINKPS,
        PSMOUSE_GENPS		= 64,	/* 4 byte protocol start */
        PSMOUSE_IMPS,
        PSMOUSE_IMEX,
        PSMOUSE_SYNAPTICS	= 128,	/* 5+ byte protocols start */
        PSMOUSE_ALPS,
};


Peter, if we adopt the scheme above you will have to check both for old and
new protocol numbers; in addition you need to BTN_TOOL_FINGER device bit to
make sure you are dealing with a touchpad.

Any holes here?
  
-- 
Dmitry
