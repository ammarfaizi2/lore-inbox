Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266807AbUHCXMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266807AbUHCXMv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 19:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266816AbUHCXMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 19:12:51 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:38625 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S266807AbUHCXMp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 19:12:45 -0400
Message-ID: <41101C44.9050400@blue-labs.org>
Date: Tue, 03 Aug 2004 19:14:12 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a3) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: linux-kernel@vger.kernel.org, Marko Macek <marko.macek@gmx.net>,
       Vojtech Pavlik <vojtech@suse.cz>, Eric Wong <eric@yhbt.net>
Subject: Re: KVM & mouse wheel
References: <410FAE9B.5010909@gmx.net> <200408031253.38934.dtor_core@ameritech.net>
In-Reply-To: <200408031253.38934.dtor_core@ameritech.net>
Content-Type: multipart/mixed;
 boundary="------------030001080207050306040702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030001080207050306040702
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I have a customer using a KVM device, the mouse works fine -until- the 
KVM is switched elsewhere and back.  After that, the mouse sends 
garbage.  X+Y movement data is completely hosed causing the mouse to 
jump around everywhere.  If I remove the module and reload it, the mouse 
partially returns.  X+Y movement is normal again however the buttons are 
now messed up.  Sometimes the buttons seem constantly pressed or 
constantly released.  The only way to recover normal mousing is to reboot.

This didn't happen back on 2.6.0-test8 and I don't think it happened on 
2.6.7.

David

Dmitry Torokhov wrote:

>Hi,
>
>On Tuesday 03 August 2004 10:26 am, Marko Macek wrote:
>  
>
>>Hello!
>>
>>A few months ago I posted about problems with 2.6 kernel, KVM and mouse
>>wheel.
>>
>>I was using 2.4 kernel until recently, but with the switch to FC2 with
>>2.6 kernel this problem became much more annoying.
>>
>>My mouse is Logitech MX 510.
>>
>>I figured out a few things.
>>
>>1. Trying to set the mouse/kvm into a stream mode makes things insane.
>>Since streaming mode is supposed to be the default, I propose not
>>doing this at all. I haven't researched this further.
>>
>>-      psmouse_command(psmouse, param, PSMOUSE_CMD_SETSTREAM);
>>    
>>
>
>Could you describe what insane mean? If you take the KVM out of the picture
>is the mouse still instane?
>
>  
>
>>2. synaptics_detect hoses imps and exps detection. Resetting the mouse
>>after failed detect fixes it. This makes 'imps' and 'exps' protocols
>>work when used as proto=imps or proto=exps. Wheel works, I haven't tried
>>the buttons.
>>
>>    
>>
>
>Again, does it work without the KVM?
>
>  
>
>>3. PS2++ detection correctly detects Logitech MX mouse but doesn't
>>enable the PS2PP protocol, because of unexpected results in this code:
>>
>>	param[0] = param[1] = param[2] = 0;
>>         ps2pp_cmd(psmouse, param, 0x39); /* Magic knock */
>>         ps2pp_cmd(psmouse, param, 0xDB);
>>
>>         if ((param[0] & 0x78) == 0x48 &&
>>             (param[1] & 0xf3) == 0xc2 &&
>>             (param[2] & 0x03) == ((param[1] >> 2) & 3)) {
>>                 ps2pp_set_smartscroll(psmouse);
>>	        protocol = PSMOUSE_PS2PP;
>>         }
>>
>>The returned param array in my case is: 08 01 00 or 08 00 00 (hex)
>>(without KVM: C8 C2 64)
>>
>>I don't understand what this code is trying to check or why the protocol
>>is only set conditionally. If I set it unconditionally (swap last 2
>>lines) the PS2++ protocol now works including detection of all buttons
>>(I don't really need the buttons, just the wheel).
>>
>>    
>>
>
>Apparently your KVM doctors the data stream from the mouse. The driver
>tries to play safe and only switches to PS2++ protocol if mouse responds
>properly, otherwise there is a chance that it uses PS2++ with mouse that
>does not actually support it. 
>
>  
>
>>This is not included in the patch. The alternative solution
>>is to reset the mouse again and resume probing for imps or exps.
>>
>>    
>>
>
>It will be probed for imps/exps if PS2++ fails. Now I suspect that your
>particular KVM does not expect any extended probes and gets confused by
>them.
>
>  
>

--------------030001080207050306040702
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

YmVnaW46dmNhcmQNCmZuOkRhdmlkIEZvcmQNCm46Rm9yZDtEYXZpZA0KZW1haWw7aW50ZXJu
ZXQ6ZGF2aWRAYmx1ZS1sYWJzLm9yZw0KdGl0bGU6SW5kdXN0cmlhbCBHZWVrDQp0ZWw7aG9t
ZTpBc2sgcGxlYXNlDQp0ZWw7Y2VsbDooMjAzKSA2NTAtMzYxMQ0KeC1tb3ppbGxhLWh0bWw6
VFJVRQ0KdmVyc2lvbjoyLjENCmVuZDp2Y2FyZA0KDQo=
--------------030001080207050306040702--
