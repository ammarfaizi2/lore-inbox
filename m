Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129588AbQKONzU>; Wed, 15 Nov 2000 08:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129895AbQKONzK>; Wed, 15 Nov 2000 08:55:10 -0500
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:10142 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S129588AbQKONy4> convert rfc822-to-8bit; Wed, 15 Nov 2000 08:54:56 -0500
From: schwidefsky@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Message-ID: <C1256998.0049AC4C.00@d12mta07.de.ibm.com>
Date: Wed, 15 Nov 2000 14:24:33 +0100
Subject: Re: Memory management bug
Mime-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>> +extern pte_t empty_bad_pte_table[];
>>  extern __inline__ void free_pte_fast(pte_t *pte)
>>  {
>> +       if (pte == empty_bad_pte_table)
>> +               return;
>
>I guess that should be BUG() instead of return, so that the callers can be
>fixed.
Not really. pte_free and pmd_free are called from the common mm code but
the concept of empty_bad_{pte,pmd}_table is architecture dependent. The
trouble starts in arch/???/mm/init.c where these special arrays are
inserted into the paging tables. So the solution to the problem should be
in architecture dependent files too.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
