Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263041AbRFFEjf>; Wed, 6 Jun 2001 00:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262629AbRFFEjZ>; Wed, 6 Jun 2001 00:39:25 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:58516 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263238AbRFFEjM>;
	Wed, 6 Jun 2001 00:39:12 -0400
Message-ID: <3B1DB3EC.AF7034@mandrakesoft.com>
Date: Wed, 06 Jun 2001 00:39:08 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Ford <david@blue-labs.org>
Cc: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac9
In-Reply-To: <20010605234928.A28971@lightning.swansea.linux.org.uk> <3B1DB270.6070603@blue-labs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:
>  >>EIP; c01269f9 <proc_getdata+4d/154>   <=====
> Trace; c01b1021 <read_eeprom+131/1a8>
> Trace; c01b1c43 <rtl8139_tx_timeout+143/148>
> Trace; c01b2643 <rtl8139_interrupt+5f/170>
> Trace; c0137fc0 <__emul_lookup_dentry+a4/fc>
> Trace; c0138871 <open_namei+4d1/560>
> Trace; c0167ccb <leaf_define_dest_src_infos+1a7/1ac>
> Trace; c012e389 <do_readv_writev+15d/228>
> Trace; c012e2c2 <do_readv_writev+96/228>

This trace looks corrupted to me... are you sure that System.map for the
crashed kernel matches -exactly- with the one ksymoops used to decode
this?  It uses /proc/ksyms by default, which is incorrect for most
postmortem ksymoops runs...

rtl8139_interrupt doesn't call tx_timeout, which doesn't call
read_eeprom, which doesn't call proc_getdata.

-- 
Jeff Garzik      | An expert is one who knows more and more about
Building 1024    | less and less until he knows absolutely everything
MandrakeSoft     | about nothing.
