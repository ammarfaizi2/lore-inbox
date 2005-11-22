Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbVKVOU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbVKVOU1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 09:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbVKVOU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 09:20:27 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:28896 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S964947AbVKVOUZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 09:20:25 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Subject: Re: Compaq Presario "reboot" problems
Date: Tue, 22 Nov 2005 16:19:25 +0200
User-Agent: KMail/1.8.2
Cc: "Stefan Seyfried" <seife@suse.de>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0511171314440.10063@chaos.analogic.com> <438218E6.4070604@suse.de> <Pine.LNX.4.61.0511220905410.11943@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0511220905410.11943@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511221619.26127.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 November 2005 16:09, linux-os (Dick Johnson) wrote:
> Okay, the results are the same. The machine reboots. It doesn't
> run the memory-test so it probably didn't cold-boot. It's hard to
> tell with these lap-tops because the time in the BIOS is so
> brief. Anyway, it reboots into Linux, but can't reboot into Windows
> as before.

You may want to try to add triple-fault reset as suggested here
(based on your own idea actually):

> If it does not, try this reboot=tc - this is closely resembles
> what you proposed in your mail (pseudo-patch):
>
> static int __init reboot_setup(char *str)
> {
>        while(1) {
>                switch (*str) {
> +               case 't': /* "triple fault" reboot */
> +                       reboot_thru_bios = 2;
> +                       break;
>                case 'w': /* "warm" reboot (no memory testing etc) */
>                        reboot_mode = 0x1234;
>                        break;
> ...
> void machine_emergency_restart(void)
> {
> +       if (reboot_thru_bios == 2) {
> +               *((unsigned short *)__va(0x472)) = reboot_mode;
> +               load_idt(&no_idt);
> +               __asm__ __volatile__("int3");
> +     }
>        if (!reboot_thru_bios) {
>                if (efi_enabled) {
>                        efi.reset_system(EFI_RESET_COLD, EFI_SUCCESS, 0, NULL);
--
vda
