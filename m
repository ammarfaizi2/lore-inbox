Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269709AbUJAFvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269709AbUJAFvl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 01:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269715AbUJAFvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 01:51:41 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:58557 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269709AbUJAFvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 01:51:39 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm4
Date: Fri, 1 Oct 2004 00:51:36 -0500
User-Agent: KMail/1.6.2
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, "J.A. Magallon" <jamagallon@able.es>
References: <20040926181021.2e1b3fe4.akpm@osdl.org> <1096590131l.11697l.1l@werewolf.able.es> <20040930173116.6de40c54.rddunlap@osdl.org>
In-Reply-To: <20040930173116.6de40c54.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410010051.36750.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 September 2004 07:31 pm, Randy.Dunlap wrote:
> On Fri, 01 Oct 2004 00:22:11 +0000 J.A. Magallon wrote:
> 
> | mice: PS/2 mouse device common for all mice
> | input: AT Translated Set 2 keyboard on isa0060/serio0
> | input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
> | 
> | If not, how can I change the protocol ? A kernel bootparam ?
> | In old X, i used 'Option "Protocol" "MouseManPlusPS/2"'.
> 
> From Documentation/kernel-parameters.txt:
> 
> 	psmouse.proto=  [HW,MOUSE] Highest PS2 mouse protocol extension to
> 			probe for (bare|imps|exps).
> 
> so for builtin mouse driver (not a loadable module), use:
> 	psmouse.proto=bare|imps|exps
> 
> However, it read/sounds like the protocol is probed/detected.
> Moreover, it also sounds like MouseManPlusPS/2 isn't listed/supported.
> The known protocols according to psmouse-base.c are:
> 
> static char *psmouse_protocols[] = {
>   "None", "PS/2", "PS2++", "PS2T++", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2"};
> 
> I guess that you can test:  psmouse.proto=bare
> or each listed option to see what helps.
> 

As far as userspace and 2.6. goes the "only true protocol" that you should
use when getting data from /dev/input/mice or /dev/input/mouseX is
ExplorerPS/2. That's because kernel translates events from input devices
into cooked PS/2 protocol and an application can request either bare PS/2,
IMPS/2 or ExplorerPS/2 flavor regardless of what kind of device is behind
/dev/input/mice

Mouseman is not supported as far as userspace goes. If you need more than 5
buttons look for "evdev" patches for X.
 
-- 
Dmitry
