Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315437AbSHXJSm>; Sat, 24 Aug 2002 05:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315440AbSHXJSm>; Sat, 24 Aug 2002 05:18:42 -0400
Received: from smtp1.libero.it ([193.70.192.51]:2759 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id <S315437AbSHXJSl>;
	Sat, 24 Aug 2002 05:18:41 -0400
Message-ID: <3D675042.A2F163D5@libero.it>
Date: Sat, 24 Aug 2002 11:22:10 +0200
From: Abramo Bagnara <abramo.bagnara@libero.it>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, it
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (1/7) entropy, take 2 - log2
References: <20020823182629.GA2224@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> 
>> +static inline __u32 int_log2_16bits(__u32 word)
>  {
>         /* Smear msbit right to make an n-bit mask */
>         word |= word >> 8;
>         word |= word >> 4;
>         word |= word >> 2;
>         word |= word >> 1;
> -       /* Remove one bit to make this a logarithm */
> -       word >>= 1;
> -       /* Count the bits set in the word */
> -       word -= (word >> 1) & 0x555;
> -       word = (word & 0x333) + ((word >> 2) & 0x333);
> -       word += (word >> 4);
> -       word += (word >> 8);
> -       return word & 15;
> +
> +       return hweight16(word)-1;
>  }
> -#endif

I suggest you to use a more efficient version like that below:

static inline int ld2_16(__u16 v)
{
        unsigned r = 0;

        if (v >= 0x100) {
                v >>= 8;
                r += 8;
        }
        if (v >= 0x10) {
                v >>= 4;
                r += 4;
        }
        if (v >= 4) {
                v >>= 2;
                r += 2;
        }
        if (v >= 2)
                r++;
        return r;
}


-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy
