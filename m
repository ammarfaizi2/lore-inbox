Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263511AbTDMN3X (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 09:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbTDMN3X (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 09:29:23 -0400
Received: from port-212-202-185-162.reverse.qdsl-home.de ([212.202.185.162]:18573
	"EHLO gw.localnet") by vger.kernel.org with ESMTP id S263511AbTDMN3W (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 09:29:22 -0400
Message-ID: <3E9968FB.8050409@trash.net>
Date: Sun, 13 Apr 2003 15:41:15 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Kevin Buhr <buhr@telus.net>
CC: Maciej Soltysiak <solt@dns.toxicfilms.tv>, netfilter-devel@lists.samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: BUG somewhere in NAT mechanism [was: my linux box does not learn
 from redirects]
References: <Pine.LNX.4.51.0304121406180.24111@dns.toxicfilms.tv> <8765pj6lg9.fsf@saurus.asaurus.invalid> <3E99574B.5060306@trash.net>
In-Reply-To: <3E99574B.5060306@trash.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patrick McHardy wrote:

>> Maciej Soltysiak <solt@dns.toxicfilms.tv> writes:
>>  
>> It looks like the relevant bit of code is:
>>
>> ip_nat_core.c:881 (in 2.4.20)
>>        /* Redirects on non-null nats must be dropped, else they'll
>>           start talking to each other without our translation, and be
>>           confused... --RR */
>>        if (hdr->type == ICMP_REDIRECT) {
>>                /* Don't care about races here. */
>>                if (info->initialized
>>                    != ((1 << IP_NAT_MANIP_SRC) | (1 << 
>> IP_NAT_MANIP_DST))
>>
>
> Apart from what you're saying, it should be:
>
>                            if (info->initialized
>                                 & ((1 << IP_NAT_MANIP_SRC) | (1 << 
> IP_NAT_MANIP_DST))
>
> otherwise (maybe that's what Maciej is seeing) redirects for 
> connections without natbindings
> will be dropped too. 


Sorry this was wrong, it seems because of null_bindings every connection 
has at least one
binding per direction.

Bye
Patrick


