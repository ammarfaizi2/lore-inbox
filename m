Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbUDANxQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 08:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbUDANxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 08:53:16 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:54232 "EHLO
	mailout3.samsung.com") by vger.kernel.org with ESMTP
	id S262910AbUDANxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 08:53:03 -0500
Date: Thu, 01 Apr 2004 19:00:01 +0530
From: mohanlal jangir <mohanlal@samsung.com>
Subject: Re: UART detection?
To: Rui Santos <rsantos@grupopie.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <00a901c417ef$fecce540$7f476c6b@sisodomain.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
X-Mailer: Microsoft Outlook Express 5.50.4927.1200
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
References: <20040401123419.152B1337F4@rd-server.pie.domain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rui Santos,
Thanks for your replies. I try to explain my question in detail.

In file serial.c, there is one array rs_table defined as follows:
static struct serial_state rs_table[RS_TABLE_SIZE] = {
 SERIAL_PORT_DFNS /* Defined in serial.h */
};

Above array is initialized with following structures.

{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS }, /* ttyS0 */ \
{ 0, BASE_BAUD, 0x2F8, 3, STD_COM_FLAGS }, /* ttyS1 */ \
{ 0, BASE_BAUD, 0x3E8, 4, STD_COM_FLAGS }, /* ttyS2 */ \
{ 0, BASE_BAUD, 0x2E8, 3, STD_COM4_FLAGS }, /* ttyS3 */

Therefore IO address and IRQ of the UARTs are hardcoded. I want to know, is
their no way to find these values at run time?

Also I add another question here. Can I use addresses 0x3F8, 0x2F8 directly
in driver? Don't I need to remap these addresses? For example, is it ok to
say
register_data = readb(0x3F8 + some_register_offset);

Regards
Mohanlal

----- Original Message -----
From: "Rui Santos" <rsantos@grupopie.com>
To: "'mohanlal jangir'" <mohanlal@samsung.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, April 01, 2004 6:06 PM
Subject: RE: UART detection?


> Hi,
>
> I do not fully understand what you mean by 'detect this inside a kernel
> module'. I think you want to compile it as a module and the modprobe it to
> get the module messages.
>
> If you compile the serial as a module on:
> - Device Drivers -> Character Devices -> Serial Drivers -> 8250/16550
Serial
> you will get a module called serial.o
>
> Remember that if you want do use modprobe to redirect the module messages,
> You need to turn off the 'Automatic Module loadind when compiling the
> kernel. You can do this ao Loadable Module Support -> Automatic Kernel
> Module Loading.
>
> Hope it helps
> Regards,
> Rui Santos
>
>
>
> -----Mensagem original-----
> De: mohanlal jangir [mailto:mohanlal@samsung.com]
> Enviada: quinta-feira, 1 de Abril de 2004 12:24
> Para: Rui Santos
> Cc: linux-kernel@vger.kernel.org
> Assunto: Re: UART detection?
>
> I want to detect this inside a kernel module. Any way to do it?
>
> Regards
> Mohanlal
>
> ----- Original Message -----
> From: "Rui Santos" <rsantos@grupopie.com>
> To: "'mohanlal jangir'" <mohanlal@samsung.com>
> Sent: Thursday, April 01, 2004 4:56 PM
> Subject: RE: UART detection?
>
>
> > Hi,
> >
> > You can find them on the kernel boot messages.
> > Something like: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> >
> > This log is usualy found at /var/log/messages
> >
> > Regards
> > Rui Santos
> >
> >
> > -----Mensagem original-----
> > De: linux-kernel-owner@vger.kernel.org
> > [mailto:linux-kernel-owner@vger.kernel.org] Em nome de mohanlal jangir
> > Enviada: quinta-feira, 1 de Abril de 2004 12:02
> > Para: linux-kernel@vger.kernel.org
> > Assunto: UART detection?
> >
> > How can I find in a kernel module, how many UARTs are present in my
> system?
> > And how can I find their IO address and IRQ?
> >
> > Regards
> > Mohanlal
> >
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
> >
>
>
>
>

