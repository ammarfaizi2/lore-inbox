Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270588AbRHIUwX>; Thu, 9 Aug 2001 16:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270590AbRHIUwN>; Thu, 9 Aug 2001 16:52:13 -0400
Received: from h131s117a129n47.user.nortelnetworks.com ([47.129.117.131]:17045
	"HELO pcard0ks.ca.nortel.com") by vger.kernel.org with SMTP
	id <S270588AbRHIUwA>; Thu, 9 Aug 2001 16:52:00 -0400
Message-ID: <3B72F821.36E0B18C@nortelnetworks.com>
Date: Thu, 09 Aug 2001 16:52:49 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: Sampsa Ranta <sampsa@netsonic.fi>, Alan Cox <laughing@shared-source.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.7-ac9 (breaks ATM connect)
In-Reply-To: <Pine.LNX.4.33.0108092210260.31580-100000@nalle.netsonic.fi> <Pine.LNX.4.33.0108092225440.31580-100000@nalle.netsonic.fi> <15218.62166.839967.47354@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Sampsa Ranta writes:
>  > Pardon me, bugs come in too easy..
>  >
>  > -           vci != ATM_VCI_ANY && vci >> dev->ci_range.vci_bits))
>  > +           vci != ATM_VCI_ANY && vci >= 1 << dev->ci_range.vci_bits))
>  >
> 
> This is rediculious, why has this expression changed when right
> above it is the same thing:
> 
>           vpi >> dev->ci_range.vpi_bits) || (vci != ATM_VCI_UNSPEC &&
> 
> Shouldn't we be changing that "vpi >> dev->ci_range.vpi_bits" boolean
> test as well?

Am I missing something?  As long as vci is unsigned isn't (vci >>
dev->ci_range.vci_bits) as a boolean value exactly the same thing as (vci >= 1
<< dev->ci_range.vci_bits) ?

As an example, take vci = 10001b and dev->ci_range.vci_bits = 4.  The answer
works out the same either way.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
