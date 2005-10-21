Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbVJUPrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbVJUPrm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 11:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbVJUPrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 11:47:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25060 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964992AbVJUPrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 11:47:41 -0400
Subject: Re: Understanding Linux addr space, malloc, and heap
From: Arjan van de Ven <arjan@infradead.org>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: "Vincent W. Freeh" <vin@csc.ncsu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <9EF45D4BE7AB7134B6342106@Satori.nominet.org.uk>
References: <4358F0E3.6050405@csc.ncsu.edu>
	 <1129903396.2786.19.camel@laptopd505.fenrus.org>
	 <4359051C.2070401@csc.ncsu.edu>
	 <1129908179.2786.23.camel@laptopd505.fenrus.org>
	 <9EF45D4BE7AB7134B6342106@Satori.nominet.org.uk>
Content-Type: text/plain
Date: Fri, 21 Oct 2005 17:47:36 +0200
Message-Id: <1129909657.2786.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-21 at 16:37 +0100, Alex Bligh - linux-kernel wrote:
> 
> --On 21 October 2005 17:22 +0200 Arjan van de Ven <arjan@infradead.org> 
> wrote:
> 
> > Ok I meant in the "while adhering to the standard" :)
> 
> More precisely, as per the man page:
> > POSIX.1b says that mprotect can be used only on regions of memory
> > obtained from mmap(2).
> 
> But what is interesting (if anything) is this:
> > ERRORS
> >        EINVAL addr is not a valid pointer, or not a  multiple  of
> >        PAGESIZE.
> 
> So if he calls mprotect with memory allocated by malloc (which should
> fail), why doesn't he get EINVAL? He says it returns 0 (meaning it
> succeeded). Which it shouldn't (unless he is stupendously lucky in
> malloc's allocation, in which case it should work).

it succeeds all right; it just does other things than you expect
perhaps ;)

your alignment code had a bug, so it would align potentially to the
wrong piece of memory


