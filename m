Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132435AbRBEMtu>; Mon, 5 Feb 2001 07:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132597AbRBEMtk>; Mon, 5 Feb 2001 07:49:40 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:2944 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S132435AbRBEMt3>; Mon, 5 Feb 2001 07:49:29 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010205133837.A485@pc8.inup.com> 
In-Reply-To: <20010205133837.A485@pc8.inup.com>  <20010205131154.I31876@pc8.inup.com> 
To: christophe barbe <christophe.barbe@inup.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IRQ and sleep_on 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 05 Feb 2001 12:48:39 +0000
Message-ID: <7066.981377319@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


christophe.barbe@inup.com said:
>  It seems to be ok. I've no more bad sleeps or more exactly rarely and
> that why I submit this to you. Is my way to do it correct ? I've
> joined at the end of this mail the modified function. 

You can't restore flags in a different function to the one you saved them 
in. It'll break.

You should probably be using the wait_event() macro instead, which does
something similar - actually it performs the check after setting up the wait
queue, rather than releasing the lock. 

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
