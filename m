Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270549AbTGNGwi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 02:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270551AbTGNGwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 02:52:38 -0400
Received: from imap.gmx.net ([213.165.64.20]:31118 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S270549AbTGNGwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 02:52:36 -0400
Message-Id: <5.2.1.1.2.20030714063443.01bcc5f0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 14 Jul 2003 09:11:39 +0200
To: Davide Libenzi <davidel@xmailserver.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy
  ...
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0307131442470.15022@bigblue.dev.mcafeelabs.c
 om>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_26166640==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_26166640==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

At 02:51 PM 7/13/2003 -0700, Davide Libenzi wrote:

>This should (hopefully) avoid other tasks starvation exploits :
>
>http://www.xmailserver.org/linux-patches/softrr.html

Yes, that ~works.  I couldn't starve root to death as a SCHED_SOFTRR user, 
but the system was very sluggish, with keystrokes taking uncomfortably 
long.  I also had some sound skips due to inheritance.  If I activate 
xmms's gl visualization under load, it inherits SCHED_SOFTRR, says "oink" 
in a very deep voice, and other xmms threads expire.  Maybe tasks shouldn't 
inherit SCHED_SOFTRR?

While testing, I spotted something pretty strange.  It's not specific to 
SCHED_SOFTRR, SCHED_RR causes it too.  If I fire up xmms's gl visualization 
with either policy, X stops getting enough sleep credit to stay at a usable 
priority even when cpu usage is low.  Fully repeatable weirdness.  See 
attached top snapshots.

         -Mike 
--=====================_26166640==_
Content-Type: application/octet-stream; name="xx"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="xx"

LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIEFiYnkgTm9ybWFsIC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQp0b3AgLSAwNTo0NDoyMCB1cCAgMToyNywgIDQgdXNlcnMsICBsb2Fk
IGF2ZXJhZ2U6IDMuOTMsIDQuNzEsIDUuMDAKVGFza3M6ICA4MyB0b3RhbCwgICA0IHJ1bm5pbmcs
ICA3OSBzbGVlcGluZywgICAwIHN0b3BwZWQsICAgMCB6b21iaWUKQ3B1KHMpOiAgOTAuNSUgdXNl
ciwgICA5LjUlIHN5c3RlbSwgICAwLjAlIG5pY2UsICAgMC4wJSBpZGxlLCAgIDAuMCUgSU8td2Fp
dApNZW06ICAgIDEyNTcxMmsgdG90YWwsICAgMTEyODYwayB1c2VkLCAgICAxMjg1MmsgZnJlZSwg
ICAgIDUwNDhrIGJ1ZmZlcnMKU3dhcDogICAyNjUwNjRrIHRvdGFsLCAgICAxNjkwMGsgdXNlZCwg
ICAyNDgxNjRrIGZyZWUsICAgIDUwMDIwayBjYWNoZWQKCiAgUElEIFVTRVIgICAgICBQUiAgTkkg
IFZJUlQgIFJFUyAgU0hSIFMgJUNQVSAlTUVNICAgIFRJTUUrICBDb21tYW5kCiA1MDM1IG1pa2Vn
ICAgICAtMiAgIDAgMjgxMzYgNzMyOCA5OTUyIFMgNjcuNiAgNS44ICAgODoxOS42MCB4bW1zCiA0
NTMyIHJvb3QgICAgICAyNSAgIDAgNjI4MDAgIDEybSAgNDZtIFIgIDguNiAgOS44ICAgMzozOC42
NCBYCiA0NTk2IHJvb3QgICAgIC01MSAgIDAgIDcyMzIgNDcyMCA1MjU2IFMgIDQuOCAgMy44ICAg
MDoyMS45MCBhcnRzZAogNDY0NyByb290ICAgICAgMTUgICAwIDIwMTAwIDgzMDAgIDE4bSBSICA0
LjggIDYuNiAgIDA6MjMuMTkga2RlaW5pdAogODYxMSBtaWtlZyAgICAgLTIgICAwIDI4MTM2IDcz
MjggOTk1MiBTICA0LjggIDUuOCAgIDA6MTkuMTYgeG1tcwogNTAxMSBtaWtlZyAgICAgLTIgICAw
IDI4MTM2IDczMjggOTk1MiBTICAzLjggIDUuOCAgIDA6MjguNzUgeG1tcwogNDY1MSByb290ICAg
ICAgMTUgICAwICAxODAwIDE4MDAgMTY0MCBSICAyLjkgIDEuNCAgIDA6NTUuODEgdG9wCiA0NTY0
IHJvb3QgICAgICAxNSAgIDAgMTkwNjggNjY2MCAgMTdtIFMgIDEuMCAgNS4zICAgMDowOS44NCBr
ZGVpbml0CiA4NjE4IG1pa2VnICAgICAtMiAgIDAgMjgxMzYgNzMyOCA5OTUyIFIgIDEuMCAgNS44
ICAgMDowMS45NCB4bW1zCiAgICAxIHJvb3QgICAgICAxNSAgIDAgIDEzODAgIDUwMCAxMzM2IFMg
IDAuMCAgMC40ICAgMDowNC4yMyBpbml0CiAgICAyIHJvb3QgICAgICAzNCAgMTkgICAgIDAgICAg
MCAgICAwIFMgIDAuMCAgMC4wICAgMDowMC4wMCBrc29mdGlycWQvMAogICAgMyByb290ICAgICAg
IDUgLTEwICAgICAwICAgIDAgICAgMCBTICAwLjAgIDAuMCAgIDA6MDAuMjEgZXZlbnRzLzAKICAg
IDQgcm9vdCAgICAgICA1IC0xMCAgICAgMCAgICAwICAgIDAgUyAgMC4wICAwLjAgICAwOjAwLjI5
IGtibG9ja2QvMAogICAgNSByb290ICAgICAgMTUgICAwICAgICAwICAgIDAgICAgMCBTICAwLjAg
IDAuMCAgIDA6MDAuMTUga2FwbWQKICAgIDYgcm9vdCAgICAgIDE1ICAgMCAgICAgMCAgICAwICAg
IDAgUyAgMC4wICAwLjAgICAwOjAwLjAwIHBkZmx1c2gKICAgIDcgcm9vdCAgICAgIDE1ICAgMCAg
ICAgMCAgICAwICAgIDAgUyAgMC4wICAwLjAgICAwOjAwLjMzIHBkZmx1c2gKICAgIDggcm9vdCAg
ICAgIDE1ICAgMCAgICAgMCAgICAwICAgIDAgUyAgMC4wICAwLjAgICAwOjAxLjAyIGtzd2FwZDAK
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSBOb3JtIE5vcm1hbCAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KdG9wIC0gMDY6MDA6MjIgdXAgIDE6NDMsICA0IHVzZXJzLCAgbG9h
ZCBhdmVyYWdlOiAxLjQ4LCAyLjM5LCAzLjQ2ClRhc2tzOiAgODUgdG90YWwsICAgMiBydW5uaW5n
LCAgODMgc2xlZXBpbmcsICAgMCBzdG9wcGVkLCAgIDAgem9tYmllCkNwdShzKTogIDk0LjIlIHVz
ZXIsICAgNS44JSBzeXN0ZW0sICAgMC4wJSBuaWNlLCAgIDAuMCUgaWRsZSwgICAwLjAlIElPLXdh
aXQKTWVtOiAgICAxMjU3MTJrIHRvdGFsLCAgIDEyMDcwMGsgdXNlZCwgICAgIDUwMTJrIGZyZWUs
ICAgICA2Mjg4ayBidWZmZXJzClN3YXA6ICAgMjY1MDY0ayB0b3RhbCwgICAgMTU4OTZrIHVzZWQs
ICAgMjQ5MTY4ayBmcmVlLCAgICA1MzI3NmsgY2FjaGVkCgogIFBJRCBVU0VSICAgICAgUFIgIE5J
ICBWSVJUICBSRVMgIFNIUiBTICVDUFUgJU1FTSAgICBUSU1FKyAgQ29tbWFuZAogODc4NCByb290
ICAgICAgMjUgICAwIDI4MDE2IDg3ODQgOTk1MiBSIDY1LjAgIDcuMCAgIDA6MzUuNzEgeG1tcwog
NDUzMiByb290ICAgICAgMTUgICAwIDYyODE2ICAxMm0gIDQ2bSBTIDE5LjQgIDkuOSAgIDU6NDYu
MzAgWAogODc4MSByb290ICAgICAgMTUgICAwIDI4MDE2IDg3ODQgOTk1MiBTICA0LjkgIDcuMCAg
IDA6MDIuNzIgeG1tcwogNDY1MSByb290ICAgICAgMTYgICAwICAxODAwIDE4MDAgMTY0MCBSICAz
LjkgIDEuNCAgIDE6MjMuOTggdG9wCiA4Nzg2IHJvb3QgICAgICAxNSAgIDAgMjgwMTYgODc4NCA5
OTUyIFMgIDMuOSAgNy4wICAgMDowMS40OCB4bW1zCiA0NTk2IHJvb3QgICAgIC01MSAgIDAgIDcy
MzIgNDcyMCA1MjU2IFMgIDEuOSAgMy44ICAgMDozMi4wMSBhcnRzZAogNDYxNCByb290ICAgICAg
MTUgICAwIDE5NjQwIDc2MjggIDE4bSBTICAxLjAgIDYuMSAgIDA6MTEuMjEga2RlaW5pdAogNDY0
NyByb290ICAgICAgMTUgICAwIDIwMjkyIDg0NDAgIDE4bSBTICAxLjAgIDYuNyAgIDA6MzUuNTUg
a2RlaW5pdAogICAgMSByb290ICAgICAgMTUgICAwICAxMzgwICA1MDAgMTMzNiBTICAwLjAgIDAu
NCAgIDA6MDQuMjUgaW5pdAogICAgMiByb290ICAgICAgMzQgIDE5ICAgICAwICAgIDAgICAgMCBT
ICAwLjAgIDAuMCAgIDA6MDAuMDAga3NvZnRpcnFkLzAKICAgIDMgcm9vdCAgICAgICA1IC0xMCAg
ICAgMCAgICAwICAgIDAgUyAgMC4wICAwLjAgICAwOjAwLjI4IGV2ZW50cy8wCiAgICA0IHJvb3Qg
ICAgICAgNSAtMTAgICAgIDAgICAgMCAgICAwIFMgIDAuMCAgMC4wICAgMDowMC4yOSBrYmxvY2tk
LzAKICAgIDUgcm9vdCAgICAgIDE1ICAgMCAgICAgMCAgICAwICAgIDAgUyAgMC4wICAwLjAgICAw
OjAwLjIyIGthcG1kCiAgICA2IHJvb3QgICAgICAxNSAgIDAgICAgIDAgICAgMCAgICAwIFMgIDAu
MCAgMC4wICAgMDowMC4wMCBwZGZsdXNoCiAgICA3IHJvb3QgICAgICAxNSAgIDAgICAgIDAgICAg
MCAgICAwIFMgIDAuMCAgMC4wICAgMDowMC4zNSBwZGZsdXNoCiAgICA4IHJvb3QgICAgICAxNSAg
IDAgICAgIDAgICAgMCAgICAwIFMgIDAuMCAgMC4wICAgMDowMS4wMiBrc3dhcGQwCgo=
--=====================_26166640==_--

