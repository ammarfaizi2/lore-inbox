Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVEYBjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVEYBjn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 21:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbVEYBjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 21:39:43 -0400
Received: from tls.sendmail.com ([209.246.26.40]:18090 "EHLO foon.sendmail.com")
	by vger.kernel.org with ESMTP id S261241AbVEYBjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 21:39:40 -0400
X-DomainKeys: Sendmail DomainKeys Filter v0.2.7 foon.sendmail.com j4P1dcS9011641
DomainKey-Signature: a=rsa-sha1; s=tls; d=sendmail.com; c=nofws; q=dns;
	b=Hvp8FKh9axVvg8eqxhR4KMnPcuwbWnCh2QxwtyO9872pWuhqnSGQcRC6Pm3akM+Kf
	DVWWXkKCK+BlOKYBejKtEsjMwLD3sf8PSo7DiVgj/5RxHrWV2JM3o1ku4Q34Nhxca1H
	T8WADxfJvZ09NfkDFDQPcuwV6LTCx9yfPyuy4yw=
Message-ID: <4293D4AF.4050903@sendmail.com>
Date: Tue, 24 May 2005 18:28:15 -0700
From: Ashish Gawarikar <ashish@sendmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, es, ja, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Memory leak in 2.6.11.10/2.6.12-rc4?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using 2.6.11.10 (and have also tried the same with 2.6.12-rc4). I 
have a Dell Poweredge 850, with 2 GB RAM. I am trying a simple test like:

#!/bin/sh
cd /var/tmp
while true;
do
    find /usr -name "*" | xargs strings > /var/tmp/spin.txt
done


And after sometime (less than 20 mins)I do see that the free command returns:



#free
             total       used       free     shared    buffers     cached
Mem:       2075060    1872904     202156          0      27696     453404
-/+ buffers/cache:    1391804     683256
Swap:      2097136          0    2097136
#

And after 15 mins:

#free
             total       used       free     shared    buffers     cached
Mem:       2075060    2002064      72996          0      11840     393372
-/+ buffers/cache:    1596852     478208
Swap:      2097136          0    2097136
#

(The only patch applied to the kernel is aacraid 2391).

After having stopped the program the free returns this:

# free
             total       used       free     shared    buffers     cached
Mem:       2075060    1951632     123428          0      15988     330064
-/+ buffers/cache:    1605580     469480
Swap:      2097136          0    2097136


Can someone please help me on this?

Thanks in advance,

Ashish
