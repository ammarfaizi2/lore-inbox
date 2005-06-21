Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVFULZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVFULZM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 07:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVFULYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 07:24:55 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:7102 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261188AbVFULDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 07:03:45 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: <cutaway@bellsouth.net>, "Jesper Juhl" <juhl-lkml@dif.dk>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] cleanup patches for strings
Date: Tue, 21 Jun 2005 14:02:48 +0300
User-Agent: KMail/1.5.4
Cc: "Andrew Morton" <akpm@osdl.org>, "Jeff Garzik" <jgarzik@pobox.com>,
       "Domen Puncer" <domen@coderock.org>
References: <Pine.LNX.4.62.0506200052320.2415@dragon.hyggekrogen.localhost> <004001c5762e$d67ff390$2800000a@pc365dualp2>
In-Reply-To: <004001c5762e$d67ff390$2800000a@pc365dualp2>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506211402.48554.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 June 2005 09:58, cutaway@bellsouth.net wrote:
> Examine each case individually...
> 
> Any code that did a "sizeof(foo)" is [very] likely to give different
> results.
> 
> Also, if there are several instances of "foo" being passed around as
> parameter, you may find the generated code gets somewhat worse if "foo" used
> to be a stack based autovar.  On x86, the const[] implementation will always
> cause a 5 byte PUSH for a parameter, whereas the autovar pointer
> implementation often will be a shorter 3 byte EBP relative push.  With many
> instances of 'foo' usage (or used in a loop), you may be better off paying
> the price of an autovar init during prolog to get the cheaper parm pushes
> later.

But that 3 byte push is fetching data from stack, while 5 byte const push
does not. I ike smaller code, but not _this_ much.

Also this smallish size advantage may be i386-specific only.
--
vda

