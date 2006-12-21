Return-Path: <linux-kernel-owner+w=401wt.eu-S1161140AbWLUCKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161140AbWLUCKx (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 21:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161143AbWLUCKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 21:10:53 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:11717 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161144AbWLUCKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 21:10:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ck+8g/64wNvZepUJzeO/zvopkoLVQoGzNo0NMp3gCJ9Lf+L23YN1LoeRq7tUmGLqSXSM/S2fHTS7SjR7nj+rwGA5hkET4G/Iely4GJtV8ex3pVDcTRlexFqdPlbu0Er/CeRYbieogdwiIbOnzO73NArax80fZBoA4r9UlgkXEsA=
Message-ID: <4807377b0612201810t66218e4u4089df818129f1ce@mail.gmail.com>
Date: Wed, 20 Dec 2006 18:10:49 -0800
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: Network drivers that don't suspend on interface down
Cc: "Matthew Garrett" <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <1166629900.3365.1428.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061219185223.GA13256@srcf.ucam.org>
	 <20061220042648.GA19814@srcf.ucam.org>
	 <200612192114.49920.david-b@pacbell.net>
	 <20061220053417.GA29877@suse.de>
	 <20061220055209.GA20483@srcf.ucam.org>
	 <1166601025.3365.1345.camel@laptopd505.fenrus.org>
	 <20061220125314.GA24188@srcf.ucam.org>
	 <1166621931.3365.1384.camel@laptopd505.fenrus.org>
	 <20061220143134.GA25462@srcf.ucam.org>
	 <1166629900.3365.1428.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/06, Arjan van de Ven <arjan@infradead.org> wrote:
>
> > Yeah, I guess that's a problem. From a user perspective, the
> > functionality is only really useful if the latency is very small. I
> > think where possible we'd want to power down the chip while keeping the
> > phy up, but it would be nice to know how much power that would actually
> > cost us.
>
> I'm no expert but afaik the PHY is the power hungry part, the rest is
> peanuts. So if we can get the PHY to sleep most of the time that would
> be great.

The MAC uses some part of power, but FYI at least e1000 already does
phy power management when IF_DOWN, if wake on lan isn't enabled, smbus
isn't enabled, etc etc.  If we started using D3 power management its
possible a whole bunch of code would go away out of e1000.

Is there some reason why we can't have the OS just do the D3
transition for all drivers that register support?  I mean, this power
management using D states is actually driver *independent* and at
least way back in the day was supposed to be implemented for "OS power
management"
