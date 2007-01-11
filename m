Return-Path: <linux-kernel-owner+w=401wt.eu-S1751349AbXAKTjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbXAKTjv (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 14:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbXAKTjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 14:39:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:52279 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbXAKTju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 14:39:50 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SfXcUqlvA6cSmW3I3+81pEa+P3QR0myzV2Tdx4t4y2crRo0tDkMbDHaOYMyj7D5oj8hkoEmtG92FP+qrhawPNkoIFVinPRBu3ru43TsiCSPHZcrfX9liRdwWDZpLzTW2rbHHBQiFP23AFbhaJSZ6xPFhDRvEKVDRUI1XlIH9SNY=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Neil Brown <neilb@suse.de>
Subject: Re: PATCH - x86-64 signed-compare bug, was Re: select() setting ERESTARTNOHAND (514).
Date: Thu, 11 Jan 2007 20:38:03 +0100
User-Agent: KMail/1.8.2
Cc: Andi Kleen <ak@suse.de>, Sean Reifschneider <jafo@tummy.com>,
       linux-kernel@vger.kernel.org
References: <20070110234238.GB10791@tummy.com> <200701110140.51842.ak@suse.de> <17829.36029.240912.274302@notabene.brown>
In-Reply-To: <17829.36029.240912.274302@notabene.brown>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701112038.03722.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 January 2007 02:02, Neil Brown wrote:
> If regs->rax is unsigned long, then I would think the compiler would
> be allowed to convert
> 
>    switch (regs->rax) {
> 	case -514 : whatever;
>    }
> 
> to a no-op, as regs->rax will never have a negative value.

In C, you never actually compare different types. They always
promoted to some common type first.

both sides of (impicit) == here get promoted to "biggest" integer,
in this case, to unsigned long. "-514" is an int, so it gets
sign extended to the width of "long" and then converted to
unsigned long.
--
vda
