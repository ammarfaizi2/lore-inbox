Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267123AbSK2Syr>; Fri, 29 Nov 2002 13:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267126AbSK2Syr>; Fri, 29 Nov 2002 13:54:47 -0500
Received: from paiol.terra.com.br ([200.176.3.18]:12946 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP
	id <S267123AbSK2Syp>; Fri, 29 Nov 2002 13:54:45 -0500
Date: Fri, 29 Nov 2002 17:02:00 -0200
From: Lucio Maciel <abslucio@terra.com.br>
To: Jochen Hein <jochen@jochen.org>
Cc: linux-kernel@vger.kernel.org,
       "rusty's trivial patch monkey" <trivial@rustcorp.com.au>
Subject: [TRIVIAL PATCH 2.5] Re: [2.5.50] uninitialized timer
Message-Id: <20021129170200.63a81b8d.abslucio@terra.com.br>
In-Reply-To: <87n0nsqmvb.fsf@gswi1164.jochen.org>
References: <87n0nsqmvb.fsf@gswi1164.jochen.org>
Organization: absoluta
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Fri__29_Nov_2002_17:02:00_-0200_08612260"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Fri__29_Nov_2002_17:02:00_-0200_08612260
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit


Fix a unitialized timer in drivers/video/fbcon.c

Its just a warning, try this patch
Try this patch


best regards
On Fri, 29 Nov 2002 18:58:16 +0100
Jochen Hein <jochen@jochen.org> wrote:

> 
> Booting 2.2.50 gives:
> 
> vesafb: framebuffer at 0xe0000000, mapped to 0xc680d000, size 1984k
> vesafb: mode is 1024x768x16, linelength=2048, pages=0
> vesafb: protected mode interface info at c000:8e10
> vesafb: scrolling: redraw
> vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
> Uninitialised timer!
> This is just a warning.  Your computer is OK
> function=0xc0249c20, data=0x0
> Call Trace: [<c011deb0>]  [<c0249c20>]  [<c011def7>]  [<c024a003>]
> [<c021855f>]  [<c0249409>]  [<c0105086>]  [<c0105058>]  [<c0106e6d>]
> Console: switching to colour frame buffer device 128x48
> 
> Passed through ksymoops I get:
> 
> ksymoops 2.4.6 on i686 2.5.50.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.5.50/ (default)
>      -m /boot/System.map-2.5.50 (default)
> 
> Warning: You did not tell me where to find symbol information.  I will
> assume that the log matches the kernel and modules that are running
> right now and I'll use the default options above for symbol resolution.
> If the current kernel and/or modules do not match the log, you can get
> more accurate output by telling me the kernel version and where to find
> map, modules, ksyms etc.  ksymoops -h explains the options.
> 
> Error (regular_file): read_ksyms stat /proc/ksyms failed
> No modules in ksyms, skipping objects
> No ksyms, skipping lsmod
> Call Trace: [<c011deb0>]  [<c0249c20>]  [<c011def7>]  [<c024a003>]  [<c021855f>]  [<c0249409>]  [<c0105086>]  [<c0105058>]  [<c0106e6d>] 
> Warning (Oops_read): Code line not seen, dumping what data is available
> 
> 
> Trace; c011deb0 <check_timer_failed+40/4c>
> Trace; c0249c20 <cursor_timer_handler+0/28>
> Trace; c011def7 <add_timer+3b/120>
> Trace; c024a003 <fbcon_startup+43/4c>
> Trace; c021855f <take_over_console+17/18c>
> Trace; c0249409 <register_framebuffer+181/1cc>
> Trace; c0105086 <init+2e/178>
> Trace; c0105058 <init+0/178>
> Trace; c0106e6d <kernel_thread_helper+5/c>
> 
> 2 warnings and 1 error issued.  Results may not be reliable.
> 
> Hope that helps.
> 
> Jochen
> 
> -- 
> Wenn Du nicht weißt was Du tust, tu's mit Eleganz.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
::: Lucio F. Maciel
::: abslucio@terra.com.br
::: icq 93065464
::: Absoluta.net

--Multipart_Fri__29_Nov_2002_17:02:00_-0200_08612260
Content-Type: application/octet-stream;
 name="fbcon.patch"
Content-Disposition: attachment;
 filename="fbcon.patch"
Content-Transfer-Encoding: base64

LS0tIGxpbnV4L2RyaXZlcnMvdmlkZW8vZmJjb24uY34JMjAwMi0xMS0yOCAwOTo1ODozMC4wMDAw
MDAwMDAgLTAyMDAKKysrIGxpbnV4L2RyaXZlcnMvdmlkZW8vZmJjb24uYwkyMDAyLTExLTI5IDE2
OjU1OjM2LjAwMDAwMDAwMCAtMDIwMApAQCAtNDU4LDYgKzQ1OCw3IEBACiAKICAgICBpZiAoaXJx
cmVzKSB7CiAJY3Vyc29yX2JsaW5rX3JhdGUgPSBERUZBVUxUX0NVUlNPUl9CTElOS19SQVRFOwor
CWluaXRfdGltZXIoJmN1cnNvcl90aW1lcik7CiAJY3Vyc29yX3RpbWVyLmV4cGlyZXMgPSBqaWZm
aWVzK0haLzUwOwogCWFkZF90aW1lcigmY3Vyc29yX3RpbWVyKTsKICAgICB9Cg==

--Multipart_Fri__29_Nov_2002_17:02:00_-0200_08612260--
