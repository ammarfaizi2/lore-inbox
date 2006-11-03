Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753125AbWKCF4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125AbWKCF4L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 00:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753126AbWKCF4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 00:56:10 -0500
Received: from gateway.insightbb.com ([74.128.0.19]:19776 "EHLO
	asav00.insightbb.com") by vger.kernel.org with ESMTP
	id S1753125AbWKCF4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 00:56:09 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AusRAFhoSkVKhRUUXWdsb2JhbACGCoY1LA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Dave Neuer <mr.fred.smoothie@pobox.com>
Subject: Re: [RFT/PATCH] i8042: remove polling timer (v6)
Date: Fri, 3 Nov 2006 00:56:02 -0500
User-Agent: KMail/1.9.3
Cc: Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200608232311.07599.dtor@insightbb.com> <161717d50610300501w240a8ce1h4d58b1f3f2f759bf@mail.gmail.com> <161717d50610300622h15d5e40w4a30e1a95b3c2564@mail.gmail.com>
In-Reply-To: <161717d50610300622h15d5e40w4a30e1a95b3c2564@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611030056.03357.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 October 2006 09:22, Dave Neuer wrote:
> On 10/30/06, Dave Neuer <mr.fred.smoothie@pobox.com> wrote:
> >
> > Maybe I'm missing something, (well actually I'm sure I'm missing
> > somethng). Looking at the code again, it's unclear to me why there is
> > even a call to the ISR in i8042_aux_write, since the latter function
> > already calls i8042_read_data.
> >
> 
> Whoops, sorry. I meant i8042_command, which is called by
> i8042_aux_write before the call to i8042_interrupt, already calls
> i8042_read_data.
>

It only calls i8042_read_data() if command is supposed to return data.
Neither I8042_CMD_AUX_SEND nor I8042_CMD_MUX_SEND wait fotr data to come
back.

Anyway, I removed call to i8042_interrupt() from i8042_aux_write() because
it is indeed unnecessary.

-- 
Dmitry
