Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265844AbRGCSuf>; Tue, 3 Jul 2001 14:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265789AbRGCSuZ>; Tue, 3 Jul 2001 14:50:25 -0400
Received: from isimail.interactivesi.com ([207.8.4.3]:23565 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S265837AbRGCSuP>; Tue, 3 Jul 2001 14:50:15 -0400
Message-ID: <3B4213DD.50005@interactivesi.com>
Date: Tue, 03 Jul 2001 13:50:05 -0500
From: Timur Tabi <ttabi@interactivesi.com>
Organization: Interactive Silicon
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: pte_val(*pte) as lvalue
In-Reply-To: <9LUWoC.A.W3G.sIQQ7@dinero.interactivesi.com.suse.lists.linux.kernel> <oupelryykh5.fsf@pigdrop.muc.suse.de> <LScPx.A.XAF.H_gQ7@dinero.interactivesi.com> <20010703194300.A31954@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>Can I ask what the nature of the PTE modification is, and where you
>are making this modification?
>
I've written a hack which enables PAT (Page Address Translation) for a 
particular page:

void set_pte_pat(pte_t *pte, unsigned long pat_index)
{
    unsigned long p = pte_val(*pte);

    p &= ~(_PAGE_PROTNONE | _PAGE_PCD | _PAGE_PWT);    // zero-out the 
relevant bits

    if (pat_index & 4)
    p |= _PAGE_PROTNONE;

    if (pat_index & 2)
    p |= _PAGE_PCD;

    if (pat_index & 1)
    p |= _PAGE_PWT;

#if CONFIG_X86_PAE
    pte->pte_high = 0;
    pte->pte_low = p;
#else
    pte_val(*pte) = p;
#endif

-- 
Timur Tabi
Interactive Silicon



