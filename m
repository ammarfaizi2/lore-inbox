Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315794AbSFCX3D>; Mon, 3 Jun 2002 19:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315806AbSFCX3C>; Mon, 3 Jun 2002 19:29:02 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:43146 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S315794AbSFCX3A>; Mon, 3 Jun 2002 19:29:00 -0400
Message-ID: <3CFBFD41.2020505@wanadoo.fr>
Date: Tue, 04 Jun 2002 01:35:29 +0200
From: =?ISO-8859-15?Q?Fran=E7ois_Cami?= <stilgar2k@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, fr
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: john slee <indigoid@higherplane.net>,
        Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        Helge Hafting <helgehaf@aitel.hist.no>,
        "Ronny T. Lampert (EED)" <Ronny.Lampert@eed.ericsson.se>,
        linux-kernel@vger.kernel.org
Subject: Re: 3c59x driver: card not responding after a while
In-Reply-To: <3CFB21C5.27BBFB66@aitel.hist.no> <Pine.LNX.4.44.0206031050170.10836-100000@netfinity.realnet.co.sz> <20020603125752.GE12322@higherplane.net> <3CFBCDBD.DF675D57@zip.com.au>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> john slee wrote:
> 
>>On Mon, Jun 03, 2002 at 10:51:34AM +0200, Zwane Mwaikambo wrote:
>>
>>>On Mon, 3 Jun 2002, Helge Hafting wrote:
>>>
>>>
>>>>I see this too.  I always thought it was the less-than-perfect ABIT BP6
>>>>loosing an irq or something.  (odd that it _always_ is the NIC that goes
>>>>though...)  I also have a k6 with the same NIC, and another
>>>>UP machine at work.  They never fail this way.
>>>>Could it be a SMP problem?
>>>
>>>I wouldn't think so, i use it on SMP extensively without a hitch.
>>
>>"me too" - have been using 3c905B cards in various SMP (and UP) boxes
>>for a couple of years now and they've never failed me, even on bp6.  in
>>fact i seem to have missed out on the plague of bp6 problems, even when
>>running dual 300a overclocked to 450.  strange.
>>
> 
> 
> That driver is solid for SMP.  It's possible that the BP6
> is losing its IRQ routing assignments, or the APIC is
> getting stuck.  We had extensive problems with that last
> year.  A workaround was implemented and as far as I can tell,
> the problem went away.
> 
> It seems to affect network cards most because they typically
> generate the most interrupts.
> 
> Try booting the machine with the `noapic' option.

If I remember correctly, back in January we (we being Andrew Morton
and myself) talked about my 3C905C-TX not willing to share an
interrupt with my SBLive!...

I've spotted the same problem, this time sharing an interrupt
between my 3C905C-TX and an Intel i82559 10/100 ethernet
controller (kernel is 2.4.19pre7).

The situation is a bit different : using the 3C905C with the
SBLive! resulted in a total lock-up of the machine, whereas using both
network cards usually generate network timeouts and weird errors.

Putting the cards in separate (meaning different IRQ lines) PCI
slots solved the problem (same solution than between 3C905 and
SBLive!). All 3 cards are now working perfectly, at the same time.

Motherboard is MSI BXMaster (i440BX).

-- 

F. CAMI
----------------------------------------------------------
  "To disable the Internet to save EMI and Disney is the
moral equivalent of burning down the library of Alexandria
to ensure the livelihood of monastic scribes."
               - John Ippolito (Guggenheim)

