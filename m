Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315540AbSGAN1O>; Mon, 1 Jul 2002 09:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315595AbSGAN1O>; Mon, 1 Jul 2002 09:27:14 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:18181 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S315540AbSGAN1N>; Mon, 1 Jul 2002 09:27:13 -0400
Message-Id: <200207011326.g61DQ0T18850@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Willy TARREAU <willy@w.ods.org>, linux-kernel@vger.kernel.org,
       Ronald.Wahl@informatik.tu-chemnitz.de
Subject: Re: [ANNOUNCE] CMOV emulation for 2.4.19-rc1
Date: Mon, 1 Jul 2002 16:25:46 -0200
X-Mailer: KMail [version 1.3.2]
References: <20020630043950.GA15516@pcw.home.local>
In-Reply-To: <20020630043950.GA15516@pcw.home.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 June 2002 02:39, Willy TARREAU wrote:
> Hi all,
>
> OK, I know that many people dislike this, but I know others
> who occasionally need it anyway. So I don't post it for general
> inclusion, but for interested people.

+       if ((*eip == 0x0F) && ((*(eip+1) & 0xF0) == 0x40)) {  /* CMOV* */
...
+       if ((*eip == 0x0F) && ((*(eip+1) & 0xF8) == 0xC8)) {  /* BSWAP */
...
+       if ((*eip == 0x0F) && ((*(eip+1) & 0xFE) == 0xB0)) {  /* CMPXCHG */
...
+       if ((*eip == 0x0F) && ((*(eip+1) & 0xFE) == 0xC0)) {  /* XADD */

You may check for 0x0F only once:

	if(*eip!=0x0f) goto invalid_opcode;
	eip++;
--
vda
