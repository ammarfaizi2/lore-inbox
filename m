Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268038AbTBYQuO>; Tue, 25 Feb 2003 11:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268042AbTBYQuO>; Tue, 25 Feb 2003 11:50:14 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:22154 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id <S268038AbTBYQuN>;
	Tue, 25 Feb 2003 11:50:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: "Moore, Robert" <robert.moore@intel.com>, "'Pavel Machek'" <pavel@ucw.cz>
Subject: Re: [ACPI] [PATCH] 1/3 ACPI resource handling
Date: Tue, 25 Feb 2003 09:57:44 -0700
User-Agent: KMail/1.4.3
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       "Walz, Michael" <michael.walz@intel.com>, t-kochi@bq.jp.nec.com,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19BB1A@orsmsx107.jf.intel.com>
In-Reply-To: <B9ECACBD6885D5119ADC00508B68C1EA0D19BB1A@orsmsx107.jf.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302250957.44409.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good grief.  If people would actually read and think about the
change instead of having a knee-jerk reaction to seeing
"#define", they would see that inline functions will not work
in this particular application.  The macros were used to
factor code that was identical except that it operated on
different structure types.  Inline functions obviously require
explicit argument declarations, while macros don't, so macros
are the only choice for this type of factoring.

In any case, this horse has been long dead.  I've posted versions of
acpi_resource_to_address64() both with and without the macros, and
haven't heard any substantial objections, so I'm assuming the ACPI
folks will either ignore them or pick the one they like best and
we can move on.

Bjorn

On Monday 24 February 2003 3:48 pm, Moore, Robert wrote:
> Yes, as long as the code is used more than once (which it appears to be),
> then of course it should be procedurized.
> Bob
> 
> -----Original Message-----
> From: Pavel Machek [mailto:pavel@ucw.cz] 
> Sent: Sunday, February 23, 2003 2:55 PM
> To: Moore, Robert
> Cc: 'Bjorn Helgaas'; Grover, Andrew; Walz, Michael; t-kochi@bq.jp.nec.com;
> linux-kernel@vger.kernel.org; acpi-devel@lists.sourceforge.net
> Subject: Re: [ACPI] [PATCH] 1/3 ACPI resource handling
> 
> Hi!
> 
> > 1) This seems like a good idea to simplify the parsing of the resource
> lists
> > 
> > 2) I'm not convinced that this buys a whole lot -- it just hides the code
> > behind a macro (something that's not generally liked in the Linux world.)
> > Would this procedure be called from more than one place?
> 
> Well, reducing code duplication *is* liked in Linux world. Use inline
> function instead of macro if possible, through.
> 	
> Pavel

