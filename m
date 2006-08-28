Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWH1AL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWH1AL3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 20:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWH1AL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 20:11:29 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:10232 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932302AbWH1AL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 20:11:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Lr0m6+8LMn11xmNgLNB0s5jPTxWFqxWADueKwLeV7Ar3JsZ1wkUVoA0YjawXN16tsA8cwQ4VmE2mKnUIsA1QPf3qk+GkAOZwCJFwI7q+KRKIaT1uGqc2TFZ54qXSvw2B7ryzl6nbDVmzjNxraT6IlwsbkYzXH4hhw47nkLsArHg=
Date: Sun, 27 Aug 2006 17:11:25 -0700
From: Chris Largret <largret@gmail.com>
To: altendew <andrew@shiftcode.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Server Attack
Message-Id: <20060827171125.5e1a0a60.largret@gmail.com>
In-Reply-To: <6011508.post@talk.nabble.com>
References: <6011508.post@talk.nabble.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm going to go ahead and top-post on this (sorry). There has to be a limited number of computers these requests are coming from since the requests are coming over TCP. I'd write a quick script to grab the ip addresses and block them at the firewall level. Maybe something like this:

tail -f /var/log/apache/access_log|grep AppleWebKit|cut '-d ' -f 1|xargs /sbin/iptables -A INPUT -p tcp -j DROP -s

I haven't tested it (don't have a problem on my current server), but it _should_ follow the Apache requests, grab the IP addresses of users with a UserAgent of AppleWebKit and drop all TCP packets from the IP address until you reset your firewall.

~ Chris Largret


On Sun, 27 Aug 2006 14:58:37 -0700 (PDT)
altendew <andrew@shiftcode.com> wrote:

> 
> Hi someone is currently sending requests to our server 20x a second.
> 
> Here is what one of the logs look like.
> 
> [CODE]
> Host: 84.77.19.46   /signUp.php?ref=1945777  
>   Http Code: 403  Date: Aug 27 17:44:38  Http Version: HTTP/1.0  Size in
> Bytes: -  
>   Referer: -  
>   Agent: Mozilla/5.0 (Macintosh; MTQ; PPC Mac OS X; en-US) AppleWebKit/578.4
> (KHTML, like Geco, Safari) OmniWeb/v643.68e=C:  
> 
> Host: 82.234.98.65   /signUp.php?ref=ec0lag  
>   Http Code: 403  Date: Aug 27 17:44:38  Http Version: HTTP/1.0  Size in
> Bytes: -  
>   Referer: -  
>   Agent: Mozilla/5.0 (Macintosh; CDB; PPC Mac OS X; en-US) AppleWebKit/126.0
> (KHTML, like Geco, Safari) OmniWeb/v554.35  
> 
> Host: 84.94.31.161   /signUp.php?ref=ec0lag  
>   Http Code: 403  Date: Aug 27 17:44:38  Http Version: HTTP/1.0  Size in
> Bytes: -  
>   Referer: -  
>   Agent: Mozilla/5.0 (Macintosh; TLD; PPC Mac OS X; en-US) AppleWebKit/502.6
> (KHTML, like Geco, Safari) OmniWeb/v401.63ive=C:  
> 
> Host: 81.49.24.92   /signUp.php?ref=1945777  
>   Http Code: 403  Date: Aug 27 17:44:38  Http Version: HTTP/1.0  Size in
> Bytes: -  
>   Referer: -  
>   Agent: Mozilla/5.0 (Macintosh; SZS; PPC Mac OS X; en-US) AppleWebKit/230.1
> (KHTML, like Geco, Safari) OmniWeb/v710.56ive=C:  
> 
> Host: 80.129.248.17   /signUp.php?ref=1945777  
>   Http Code: 403  Date: Aug 27 17:44:38  Http Version: HTTP/1.0  Size in
> Bytes: -  
>   Referer: -  
>   Agent: Mozilla/5.0 (Macintosh; OST; PPC Mac OS X; en-US) AppleWebKit/243.6
> (KHTML, like Geco, Safari) OmniWeb/v846.88  
> 
> Host: 87.235.49.194   /signUp.php?ref=ec0lag  
>   Http Code: 403  Date: Aug 27 17:44:38  Http Version: HTTP/1.1  Size in
> Bytes: -  
>   Referer: -  
>   Agent: Mozilla/5.0 (Macintosh; SDD; PPC Mac OS X; en-US) AppleWebKit/430.1
> (KHTML, like Geco, Safari) OmniWeb/v145.34  
> 
> Host: 125.129.12.61   /signUp.php?ref=1945777  
>   Http Code: 403  Date: Aug 27 17:44:38  Http Version: HTTP/1.0  Size in
> Bytes: -  
>   Referer: -  
>   Agent: Mozilla/5.0 (Macintosh; WCG; PPC Mac OS X; en-US) AppleWebKit/455.3
> (KHTML, like Geco, Safari) OmniWeb/v042.84stemDrive=\x81  
> 
> Host: 66.110.153.47   /signUp.php?ref=ec0lag  
>   Http Code: 403  Date: Aug 27 17:44:38  Http Version: HTTP/1.0  Size in
> Bytes: -  
>   Referer: -  
>   Agent: Mozilla/5.0 (Macintosh; ZAM; PPC Mac OS X; en-US) AppleWebKit/387.2
> (KHTML, like Geco, Safari) OmniWeb/v456.02ve=C:  
> 
> Host: 62.2.177.250   /signUp.php?ref=ec0lag  
>   Http Code: 403  Date: Aug 27 17:44:38  Http Version: HTTP/1.0  Size in
> Bytes: -  
>   Referer: -  
>   Agent: Mozilla/5.0 (Macintosh; LMZ; PPC Mac OS X; en-US) AppleWebKit/206.1
> (KHTML, like Geco, Safari) OmniWeb/v204.07es  
> 
> Host: 200.115.226.143   /signUp.php?ref=1945777  
>   Http Code: 403  Date: Aug 27 17:44:37  Http Version: HTTP/1.1  Size in
> Bytes: -  
>   Referer: -  
>   Agent: Mozilla/5.0 (Macintosh; EDE; PPC Mac OS X; en-US) AppleWebKit/647.0
> (KHTML, like Geco, Safari) OmniWeb/v760.47emDrive=C:\x81  
> 
> Host: 84.171.125.189   /signUp.php?ref=1945777  
>   Http Code: 403  Date: Aug 27 17:44:37  Http Version: HTTP/1.0  Size in
> Bytes: -  
>   Referer: -  
>   Agent: Mozilla/5.0 (Macintosh; QHA; PPC Mac OS X; en-US) AppleWebKit/778.0
> (KHTML, like Geco, Safari) OmniWeb/v456.03=C:  
> 
> Host: 83.242.79.70   /signUp.php?ref=1945777  
>   Http Code: 403  Date: Aug 27 17:44:37  Http Version: HTTP/1.0  Size in
> Bytes: -  
>   Referer: -  
>   Agent: Mozilla/5.0 (Macintosh; GFS; PPC Mac OS X; en-US) AppleWebKit/537.0
> (KHTML, like Geco, Safari) OmniWeb/v313.01rive=C:  
> 
> Host: 86.69.194.172   /signUp.php?ref=ec0lag  
>   Http Code: 403  Date: Aug 27 17:44:37  Http Version: HTTP/1.0  Size in
> Bytes: -  
>   Referer: -  
>   Agent: Mozilla/5.0 (Macintosh; ZCV; PPC Mac OS X; en-US) AppleWebKit/468.2
> (KHTML, like Geco, Safari) OmniWeb/v026.14stemDrive=\x81  
> 
> Host: 196.203.176.26   /signUp.php?ref=ec0lag  
>   Http Code: 403  Date: Aug 27 17:44:37  Http Version: HTTP/1.1  Size in
> Bytes: -  
>   Referer: -  
>   Agent: Mozilla/5.0 (Macintosh; BXT; PPC Mac OS X; en-US) AppleWebKit/840.3
> (KHTML, like Geco, Safari) OmniWeb/v767.50s  
> 
> Host: 201.41.241.190   /signUp.php?ref=1945777  
>   Http Code: 403  Date: Aug 27 17:44:37  Http Version: HTTP/1.0  Size in
> Bytes: -  
>   Referer: -  
>   Agent: Mozilla/5.0 (Macintosh; TYZ; PPC Mac OS X; en-US) AppleWebKit/742.0
> (KHTML, like Geco, Safari) OmniWeb/v715.65C:  
> 
> Host: 200.84.144.234   /signUp.php?ref=ec0lag  
>   Http Code: 403  Date: Aug 27 17:44:37  Http Version: HTTP/1.1  Size in
> Bytes: -  
>   Referer: -  
>   Agent: Mozilla/5.0  
> [/CODE]
> 
> We are currently blocking this user through our Apache.
> 
> .htaccess
> [CODE]
> RewriteEngine On 
> RewriteCond %{HTTP_USER_AGENT} ^Mozilla/5\.0\ \(Macintosh;\ (.+)\ PPC\ Mac\
> OS\ X;\ en-US\)\ AppleWebKit/(.+)\ \(KHTML,\ like\ Geco,\ Safari\)\
> OmniWeb/v([0-9]+).([0-9]+)(.+)$
> RewriteRule .* - [F]
> [/CODE]
> 
> That works fine and is giving the user a 403 (Forbidden), but the problem is
> that half of our Apache processes are from this user.
> 
> Is there a way to block his user agent before he gets to Apache? Sometimes
> this brings our server to a crash.
> 
> Thanks
> Andrew
> -- 
> View this message in context: http://www.nabble.com/Server-Attack-tf2174025.html#a6011508
> Sent from the linux-kernel forum at Nabble.com.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Chris Largret <http://www.largret.com>
