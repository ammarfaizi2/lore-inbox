Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267566AbUI1G0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267566AbUI1G0k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 02:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267568AbUI1G0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 02:26:40 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:31056 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267566AbUI1G0Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 02:26:24 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG: 2.6.9-rc2-bk11] input completely dead in X
Date: Tue, 28 Sep 2004 01:26:19 -0500
User-Agent: KMail/1.6.2
Cc: Micha Feigin <michf@post.tau.ac.il>, Peter Osterlund <petero2@telia.com>,
       Vojtech Pavlik <vojtech@suse.cz>
References: <20040926210450.GA2960@luna.mooo.com> <20040927124321.GC7486@luna.mooo.com> <20040927145223.GA3117@luna.mooo.com>
In-Reply-To: <20040927145223.GA3117@luna.mooo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409280126.19919.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resending as I forgot to CC Vojtech and Peter first time around...

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
        PSMOUSE_PS2             = 0,
        PSMOUSE_PS2PP,
        PSMOUSE_THINKPS,
        PSMOUSE_GENPS           = 64,   /* 4 byte protocol start */
        PSMOUSE_IMPS,
        PSMOUSE_IMEX,
        PSMOUSE_SYNAPTICS       = 128,  /* 5+ byte protocols start */
        PSMOUSE_ALPS,
};


Peter, if we adopt the scheme above you will have to check both for old and
new protocol numbers; in addition you need to BTN_TOOL_FINGER device bit to
make sure you are dealing with a touchpad.

Any holes here?
  
-- 
Dmitry
