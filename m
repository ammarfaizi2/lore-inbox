Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267059AbTBTWCD>; Thu, 20 Feb 2003 17:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267084AbTBTWCD>; Thu, 20 Feb 2003 17:02:03 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:44812 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id <S267059AbTBTWCC>;
	Thu, 20 Feb 2003 17:02:02 -0500
Date: Thu, 20 Feb 2003 23:11:55 +0100
From: romieu@fr.zoreil.com
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] cli() for net/atm/lec.c
Message-ID: <20030220231155.A2347@electric-eye.fr.zoreil.com>
References: <200302201751.h1KHpKqA009567@locutus.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200302201751.h1KHpKqA009567@locutus.cmf.nrl.navy.mil>; from chas@locutus.cmf.nrl.navy.mil on Thu, Feb 20, 2003 at 12:51:20PM -0500
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chas williams <chas@locutus.cmf.nrl.navy.mil> :
[...]
> @@ -2175,22 +2173,21 @@
>          }
>          if (!entry) {
>                  DPRINTK("LEC_ARP: Arp_check_empties: entry not found!\n");
> -                lec_arp_unlock(priv);
> +                lec_arp_put(priv);
>                  return;
>          }
> -        save_flags(flags);
> -        cli();
> +        LEC_ARP_LOCK();
>          del_timer(&entry->timer);
>          memcpy(entry->mac_addr, src, ETH_ALEN);
>          entry->status = ESI_FORWARD_DIRECT;
>          entry->last_used = jiffies;
>          prev->next = entry->next;
> -        restore_flags(flags);
> +        LEC_ARP_UNLOCK();

It isn't completely trivial that the prev <-> entry relationship
still holds at the point where LEC_ARP_LOCK() is called. Widening
the protected region would spare some brain cycles imho.

--
Ueimor
