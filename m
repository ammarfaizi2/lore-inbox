Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWBCP7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWBCP7k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 10:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWBCP7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 10:59:40 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:40565 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750945AbWBCP7j convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 10:59:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O3zsGIQIAx6ecgAroutrhPTY7SZPleOWa1xPaWwLZTnjc7QwekCe/LeJpcxxcIKoQYe9JlbcxJhKD58ovgeNEbXdr4i8AXjTdH8wQdb/9N0pi2mso+Y/h2CtDAHFpSvdl7NJHhMxNkLZvebtaAHSO6weKR2DJ57QIQpdRSSrC60=
Message-ID: <fad2c7740602030759i65e45a6as29964b8e90aeecd7@mail.gmail.com>
Date: Fri, 3 Feb 2006 17:59:38 +0200
From: Juhani Rautiainen <juhani.rautiainen@gmail.com>
To: "Brown, Len" <len.brown@intel.com>
Subject: Re: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Cc: Joerg Sommrey <jo@sommrey.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       tony@atomide.com, erik@slagter.name, alan@lxorguk.ukuu.org.uk
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005EFE84D@hdsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <F7DC2337C7631D4386A2DF6E8FB22B3005EFE84D@hdsmsx401.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/06, Brown, Len <len.brown@intel.com> wrote:
>
>
> Certainly the BIOS writer also had access to that document, plus
> documents we do not see, yet they decided NOT to enable C2/C3.

This comes from AMD-768 reveision guide. In product errata there there
is errata number
24 which seems to suggest that you can't enable POS, C2 or C3 states
in single processor
environments. This at the end of errata:
----- snip ----
This workaround will not work for awaking from the C2/C3 state, since
the operating
system has full control. The (ACPI C2/C3) state support is not
required for Microsoft-compatible workstation and server platforms.

It is recommended that BIOS should disable the C2 state by
clearing bit C2EN (device B function 3 offset 4F'h). It is recommended
that BIOS should disable the C3 state by clearing bit C3EN (device B
function 3 offset 4F'h).
---- snip ----

If I understand errata correctly then enabling C2/C3 should be safe in
SMP environment put
not in single processor enviroment. Maybe module should check this
before enabling C3.

Link:
http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/24472.pdf

Regards,
Juhani
