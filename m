Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbTKTKDu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 05:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbTKTKDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 05:03:50 -0500
Received: from mail1.cc.huji.ac.il ([132.64.1.17]:41652 "EHLO
	mail1.cc.huji.ac.il") by vger.kernel.org with ESMTP id S261476AbTKTKDr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 05:03:47 -0500
Message-ID: <3FBC917E.7090506@mscc.huji.ac.il>
Date: Thu, 20 Nov 2003 12:03:42 +0200
From: Voicu Liviu <pacman@mscc.huji.ac.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030906
X-Accept-Language: en-us, en, he
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Christopher Li <lkml@chrisli.org>,
       Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-mm4 (only) and vmware
References: <20031119181518.0a43c673.vmlinuz386@yahoo.com.ar> <20031119223425.GA20549@64m.dyndns.org> <20031120014718.GA22764@holomorphy.com> <20031119232246.GA20840@64m.dyndns.org> <20031120023457.GC22764@holomorphy.com> <20031119234037.GC20840@64m.dyndns.org> <20031120025730.GD22764@holomorphy.com>
In-Reply-To: <20031120025730.GD22764@holomorphy.com>
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

May I have the patch of this vmware fix to run a few tests?
Best regards,
Liviu

William Lee Irwin III wrote:

>On Wed, Nov 19, 2003 at 06:34:57PM -0800, William Lee Irwin III wrote:
>  
>
>>>I'm going to ruminate on non-fatal methods of complaining loudly.
>>>      
>>>
>
>On Wed, Nov 19, 2003 at 06:40:37PM -0500, Christopher Li wrote:
>  
>
>>SPARSE checker?
>>    
>>
>
>I was thinking of teaching the fault handlers to complain about
>->nopage() methods returning invalid results in a non-fatal manner,
>possibly with code consolidation.
>
>e.g. every arch does:
>
>	switch (handle_mm_fault(...)) {
>		case VM_FAULT_MINOR:
>			tsk->min_flt++;
>			break;
>		case VM_FAULT_MAJOR:
>			tsk->maj_flt++;
>			break;
>		case VM_FAULT_SIGBUS:
>			goto do_sigbus;
>		case VM_FAULT_OOM:
>			goto out_of_memory;
>		default:
>			BUG();
>	}
>
>which is vaguely repetitive. It's not immediately clear how to
>consolidate gotos, which is where the thought starts happening.
>
>The other part was replacing default: BUG() with something that
>complained (e.g. putting print_symbol() to use on the ->nopage()
>method) and treating the invalid statuses like OOM, but that's
>not really very hard to do (I posted something that did some
>crude reporting of that kind already to handle the sound/ bogons).
>
>
>-- wli
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>


-- 
Liviu Voicu
Assistant Programmer and network support
Computation Center, Mount Scopus
Hebrew University of Jerusalem
Tel: 972(2)-5881253
E-mail: "Liviu Voicu"<pacman@mscc.huji.ac.il>

/**
 * cat /usr/src/linux/arch/i386/boot/bzImage > /dev/dsp
 * ( and the voice of God will be heard! )
 *
 */

Click here to see my GPG signature:
----------------------------------
	http://search.keyserver.net:11371/pks/lookup?template=netensearch%2Cnetennomatch%2Cnetenerror&search=pacman%40mscc.huji.ac.il&op=vindex&fingerprint=on&submit=Get+List


