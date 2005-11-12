Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbVKLSf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbVKLSf0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 13:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbVKLSf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 13:35:26 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:60086 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932450AbVKLSf0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 13:35:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qXl/9KZN+v3BC8F5HOGBLAY02qQ4F41J+AXDlpXZZSyGLjZf3oYvCPu6hDlrUTW0N4ePvkZBYtF6A/BgWG852/1SVMDzMLBssGjhltqG+z4Qt9Z4gnDRKvtVASCzWIPEKlqWNINvmVyWof3n+NVngUU89DBtEcSLnmKFap7V2Uk=
Message-ID: <cbec11ac0511121035w3f697824l3d1e3351e229fba4@mail.gmail.com>
Date: Sun, 13 Nov 2005 07:35:23 +1300
From: Ian McDonald <imcdnzl@gmail.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: Breakage in net/ipv4/tcp_vegas.c
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200511111336.jABDajMd019962@pincoya.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200511111336.jABDajMd019962@pincoya.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/05, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
>   CC [M]  net/ipv4/tcp_vegas.o
> net/ipv4/tcp_vegas.c: In function 'tcp_vegas_cong_avoid':
> net/ipv4/tcp_vegas.c:239: error: 'cnt' undeclared (first use in this function)

This has been fixed in the networking tree which I imagine Linus will
merge again soon but here is the fix before then:
Recent TCP changes broke the build.

Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

diff --git a/net/ipv4/tcp_vegas.c b/net/ipv4/tcp_vegas.c
index 4376814..b7d296a 100644
--- a/net/ipv4/tcp_vegas.c
+++ b/net/ipv4/tcp_vegas.c
@@ -236,7 +236,7 @@ static void tcp_vegas_cong_avoid(struct
                       /* We don't have enough RTT samples to do the Vegas
                        * calculation, so we'll behave like Reno.
                        */
-                       tcp_reno_cong_avoid(sk, ack, seq_rtt, in_flight, cnt);
+                       tcp_reno_cong_avoid(sk, ack, seq_rtt, in_flight, flag);
               } else {
                       u32 rtt, target_cwnd, diff;

--
Ian McDonald
http://wand.net.nz/~iam4
WAND Network Research Group
University of Waikato
New Zealand
