Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbTDQF4U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 01:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbTDQFyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 01:54:17 -0400
Received: from dp.samba.org ([66.70.73.150]:28114 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263112AbTDQFyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 01:54:01 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>,
       coreteam@netfilter.org
Subject: Re: [netfilter-core] [PATCH] compile fix ipfw 
In-reply-to: Your message of "Wed, 16 Apr 2003 21:11:31 -0400."
             <Pine.LNX.4.44.0304162109530.12650-100000@chimarrao.boston.redhat.com> 
Date: Thu, 17 Apr 2003 15:16:58 +1000
Message-Id: <20030417060556.75AA12C019@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0304162109530.12650-100000@chimarrao.boston.redhat.co
m> you write:
> 
> In the patch that went to marcelo a few days ago the reset
> argument to ip_chain_procinfo() got removed, but there's still
> a code block inside the function that references that variable.
> 
> This patch gets rid of that (presumably old) code block. Note
> that I didn't cc this to Marcelo because I'm not 100% sure, so
> please check it.

This looks fine to me: there used to be magic in 2.0 which meant when
you opened the proc file for writing as well as reading, it'd reset
the counters.

These days, the infrastructure doesn't support such a hack.

Please fwd to Marcelo.

Thanks!
Rusty.

> @@ -1176,12 +1176,6 @@ static int ip_chain_procinfo(int stage, 
>  			len = last_len;
>  			break;
>  		}
> -		else if(reset)
> -		{
> -			/* This needs to be done at this specific place! */
> -			i->fw_pcnt=0L;
> -			i->fw_bcnt=0L;
> -		}
>  		last_len = len;
>  		i=i->fw_next;
>  	}
> 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
