Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279593AbRJXUsx>; Wed, 24 Oct 2001 16:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279594AbRJXUso>; Wed, 24 Oct 2001 16:48:44 -0400
Received: from home.geizhals.at ([213.229.14.34]:56844 "HELO home.geizhals.at")
	by vger.kernel.org with SMTP id <S279593AbRJXUsa>;
	Wed, 24 Oct 2001 16:48:30 -0400
Message-ID: <3BD729B6.6030902@geizhals.at>
Date: Wed, 24 Oct 2001 22:51:02 +0200
From: "Marinos J. Yannikos" <mjy@geizhals.at>
Organization: Geizhals Preisvergleich
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.5) Gecko/20011011
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gdth / SCSI read performance issues (2.2.19 and 2.4.10)
In-Reply-To: <3BD6B278.3070300@geizhals.at> <3BD6ECE6.8C9435C4@zip.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Well that's pretty bad, isn't it?


We could have bought a much cheaper controller and slower disks ;-)


> - Disable CONFIG_HIGHMEM 


That seems to have no effect on performance. Btw., the 64GB support in
2.4.10 seemed to be buggy ("0-order allocation failed", then the DB
crashed), so we were using the 4GB setting.


> - Try linux-2.4.13


This helped - now performance is up to par with 2.2.19 (~ 85MB/s) - thanks!


> - Profile the kernel. [...]  With something like:
> 	~/kern-prof.sh cp some_huge_file /dev/null


I tried this, but with
  dd if=/dev/sda of=/dev/null bs=1024k count=3000

(the fs is too slow - so "cp" peaks out at 17MB/s!)

The result (last 4 lines):
c01388fc try_to_free_buffers                          55   0.1511
c0128b10 file_read_actor                            1179  14.0357
c01053b0 default_idle                               6784 130.4615
00000000 total                                      8695   0.0065

Does this suggest that the kernel isn't the bottleneck?


Regards,
  Marinos
-- 
Marinos Yannikos, CEO
Preisvergleich Internet Services AG
Franzensbrückenstraße 8/2/16, A-1020 Wien
Tel./Fax: (+431) 5811609-52/-55

