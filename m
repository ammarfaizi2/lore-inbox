Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751562AbWGPJcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbWGPJcR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 05:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWGPJcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 05:32:17 -0400
Received: from dee.erg.abdn.ac.uk ([139.133.204.82]:24211 "EHLO erg.abdn.ac.uk")
	by vger.kernel.org with ESMTP id S1750831AbWGPJcQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 05:32:16 -0400
From: Gerrit Renker <gerrit@erg.abdn.ac.uk>
Organization: Electronics Research Group, UoA
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCHv2  2.6.18-rc1-mm2   1/3]  net:  UDP-Lite generic support
Date: Sun, 16 Jul 2006 10:29:48 +0100
User-Agent: KMail/1.8.3
Cc: akpm@osdl.org, davem@davemloft.net, yoshfuji@linux-ipv6.org,
       kuznet@ms2.inr.ac.ru, jmorris@namei.org, kaber@coreworks.de,
       pekkas@netcore.fi, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <E1G1kGi-000549-00@gondolin.me.apana.org.au>
In-Reply-To: <E1G1kGi-000549-00@gondolin.me.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607161029.48628@strip-the-willow>
X-ERG-MailScanner: Found to be clean
X-ERG-MailScanner-From: gerrit@erg.abdn.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Herbert Xu:
|  >                case SO_NO_CHECK:
|  > -                       sk->sk_no_check = valbool;
|  > +                       /* UDP-Lite (RFC 3828) mandates checksumming,
|  > +                        * hence user must not enable this option.   */
|  > +                       if (sk->sk_protocol == IPPROTO_UDPLITE)
|  > +                               ret = -EOPNOTSUPP;
|  > +                       else
|  > +                           sk->sk_no_check = valbool;
|  
|  Please don't add protocol-specific stuff to generic functions.  In this
|  case why don't you just ignore sk_no_check for UDPLITE as we do for TCP?

Thank you for spotting this -- the UDP-Lite code indeed ignores sk_no_check
and will (if no socket options are set) emulate UDP with sk_no_check = 0. Setting
it to 1 will make no difference; so the above is more not strictly necessary. Will 
remove in next patch.
Any other comments or ideas, please do not hesitate to write. 

-- Gerrit
