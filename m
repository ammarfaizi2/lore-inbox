Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131669AbRDSSJl>; Thu, 19 Apr 2001 14:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131886AbRDSSJb>; Thu, 19 Apr 2001 14:09:31 -0400
Received: from yoda.planetinternet.be ([195.95.30.146]:44297 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S131669AbRDSSJP>; Thu, 19 Apr 2001 14:09:15 -0400
Date: Thu, 19 Apr 2001 20:09:05 +0200
From: Kurt Roeckx <Q@ping.be>
To: linux-kernel@vger.kernel.org
Subject: Re: KERNEL: assertion (tp->lost_out == 0) failed at tcp_input.c(1202):tcp_remove_reno_sacks
Message-ID: <20010419200905.A2970@ping.be>
In-Reply-To: <20010414164254.A13247@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <20010414164254.A13247@ping.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 14, 2001 at 04:42:54PM +0200, Kurt Roeckx wrote:
> While running 2.4.3, I saw the following message a few times:
> 
> KERNEL: assertion (tp->lost_out == 0) failed at
> tcp_input.c(1202):tcp_remove_reno_sacks

I've been running tcpdump for some time, and get the message 2
times again today.

Apr 19 19:05:17 thunderbird kernel: KERNEL: assertion (tp->lost_out == 0)
failed at tcp_input.c(1202):tcp_remove_reno_sacks
Apr 19 19:07:18 thunderbird kernel: KERNEL: assertion (tp->lost_out == 0)
failed at tcp_input.c(1202):tcp_remove_reno_sacks

I'm going to start with the second one, because there was alot less trafic at that time.

19:07:17.571150 3ffe:80c0:220::b.6667 > 3ffe:400:290:100:2a0:c9ff:feaa:635e.1060: . 1921:3141(1220) ack 1811 win 5680 (len 1240, hlim 64)
19:07:17.571163 3ffe:80c0:220::b.6667 > 3ffe:400:290:100:2a0:c9ff:feaa:635e.1060: P 3141:3341(200) ack 1811 win 5680 (len 220, hlim 64)
19:07:17.572431 3ffe:401:0:1::16:2 > 3ffe:80c0:220::b: icmp6: too big 1280
 (len 1240, hlim 63)
19:07:17.645807 3ffe:8010:91::26.2237 > 3ffe:80c0:220::b.6667: S [tcp sum ok] 2268475160:2268475160(0) win 32660 <mss 1420,sackOK,timestamp 54007992 0,nop,wscale 0> (len 40, hlim 61)
19:07:17.816319 3ffe:1001:211:80:baba:beba:deca:ceca.33258 > 3ffe:80c0:220::b.6667: . [tcp sum ok] 290:290(0) ack 14134 win 34160 (len 20, hlim 60)
19:07:18.186433 3ffe:400:290:100:2a0:c9ff:feaa:635e.1060 > 3ffe:80c0:220::b.6667: . [tcp sum ok] 1811:1811(0) ack 3341 win 15620 (len 20, hlim 59)
19:07:18.186465 3ffe:80c0:220::b.6667 > 3ffe:400:290:100:2a0:c9ff:feaa:635e.1060: . 3341:4561(1220) ack 1811 win 5680 (len 1240, hlim 64)
19:07:18.886979 3ffe:400:290:100:2a0:c9ff:feaa:635e.1060 > 3ffe:80c0:220::b.6667: . [tcp sum ok] 1811:1811(0) ack 4561 win 17040 (len 20, hlim 59)
19:07:18.887047 3ffe:80c0:220::b.6667 > 3ffe:400:290:100:2a0:c9ff:feaa:635e.1060: P 4561:4761(200) ack 1811 win 5680 (len 220, hlim 64)
19:07:19.236653 3ffe:8010:14::1:dead:beef.3207 > 3ffe:80c0:220::b.6667: S [tcp sum ok] 2702352776:2702352776(0) win 31680 <mss 1440,sackOK,timestamp 113753265 0,nop,wscale 0> (len 40, hlim 60)

As you can see, during that second there only was trafic of 1 connection.

Some part of the tcpdump around the time of the first:

19:05:16.783871 3ffe:8010:7:43:1000:dead:dead:2.3292 > 3ffe:80c0:220::b.6667: P
[tcp sum ok] 134:152(18) ack 1104 win 31520 (len 38, hlim 60)
19:05:16.783923 3ffe:80c0:220::b.6667 > 3ffe:8010:7:43:1000:dead:dead:2.3292: .
[tcp sum ok] 3321:3321(0) ack 152 win 5680 (len 20, hlim 64)
19:05:16.849145 3ffe:400:680:aaaa::aaaa:15.1117 > 3ffe:80c0:220::b.6667: . [tcp
sum ok] 124:124(0) ack 38670 win 32660 (len 20, hlim 61)
19:05:16.921394 3ffe:8060:100::26:2 > 3ffe:80c0:220::b: icmp6: too big 1280
 (len 1240, hlim 63)
19:05:16.972044 3ffe:8191::2.1044 > 3ffe:80c0:220::b.6667: . [tcp sum ok] 73:73(0) ack 8784 win 17040 (len 20, hlim 60)
19:05:16.972143 3ffe:80c0:220::b.6667 > 3ffe:8191::2.1044: P 8784:8984(200) ack
73 win 5680 (len 220, hlim 64)
19:05:17.030129 3ffe:80c0:220::b.6667 > 3ffe:b00:4011:a::3.1880: P 76:1163(1087) ack 213 win 5680 (len 1107, hlim 64)
19:05:17.062691 3ffe:80c0:220::b.6667 > 3ffe:b00:4011:a::3.1880: P 1163:2383(1220) ack 213 win 5680 (len 1240, hlim 64)
19:05:17.097973 3ffe:80c0:220::b.6666 > 3ffe:1200:3028:82ca:4:4:4:6.2160: P 205:819(614) ack 256 win 5680 (len 634, hlim 64)
19:05:17.098080 3ffe:80c0:220::b.6666 > 3ffe:8114:2000:1d0::4.2856: P 3811:4198(387) ack 85 win 5680 (len 407, hlim 64)
19:05:17.098135 3ffe:80c0:220::b.6667 > 3ffe:400:680:aaaa::aaaa:15.1117: . 38670:40090(1420) ack 124 win 5680 (len 1440, hlim 64)
19:05:17.098151 3ffe:80c0:220::b.6667 > 3ffe:400:680:aaaa::aaaa:15.1117: P 40090:40197(107) ack 124 win 5680 (len 127, hlim 64)
19:05:17.098860 3ffe:80c0:220::b.6667 > 3ffe:80e8:140:200::1.3899: P 158:1049(891) ack 85 win 5680 (len 911, hlim 64)
19:05:17.106040 3ffe:80c0:220::b.6667 > 3ffe:80c0:220::19.1998: P 5851:6543(692) ack 475 win 5680 (len 712, hlim 64)
19:05:17.108239 3ffe:80c0:220::b.4126 > 3ffe:1001:340::6.113: S [tcp sum ok] 2552352896:2552352896(0) win 5680 <mss 1420,sackOK,timestamp 11315112 0,nop,wscale
0> (len 40, hlim 64)
19:05:17.258572 3ffe:401:0:1::16:2 > 3ffe:80c0:220::b: icmp6: too big 1280
 (len 1240, hlim 63)
19:05:17.258633 3ffe:80c0:220::b.6667 > 3ffe:400:680:aaaa::aaaa:15.1117: . 38670:39890(1220) ack 124 win 5680 (len 1240, hlim 64)
19:05:17.321612 3ffe:8010:7:43:1000:dead:dead:2.3292 > 3ffe:80c0:220::b.6667: P
152:244(92) ack 1104 win 31520 (len 112, hlim 60)
19:05:17.321636 3ffe:80c0:220::b.6667 > 3ffe:8010:7:43:1000:dead:dead:2.3292: .
[tcp sum ok] 3321:3321(0) ack 244 win 5680 (len 20, hlim 64)
19:05:17.364448 3ffe:80c0:220::b.6667 > 3ffe:400:680:11::aaaa:aa15.3452: P [tcp
sum ok] 770:789(19) ack 67 win 5680 (len 39, hlim 64)
19:05:17.370740 3ffe:400:680:11::aaaa:aa15.3452 > 3ffe:80c0:220::b.6667: P [tcp
sum ok] 51:67(16) ack 770 win 48800 (len 36, hlim 60)
19:05:17.370761 3ffe:80c0:220::b.6667 > 3ffe:400:680:11::aaaa:aa15.3452: . [tcp
sum ok] 789:789(0) ack 67 win 5680 <nop,nop,sack sack 1 {51:67} > (len 32, hlim
64)
19:05:17.390719 3ffe:8114:2000:1d0::4.2856 > 3ffe:80c0:220::b.6666: . [tcp sum ok] 85:85(0) ack 4198 win 32660 (len 20, hlim 60)
19:05:17.393180 3ffe:400:680:aaaa::aaaa:15.1117 > 3ffe:80c0:220::b.6667: . [tcp
sum ok] 124:124(0) ack 38670 win 32660 <nop,nop,sack sack 1 {40090:40197} > (len 32, hlim 61)
19:05:17.393197 3ffe:80c0:220::b.6667 > 3ffe:400:680:aaaa::aaaa:15.1117: . 39890:40090(200) ack 124 win 5680 (len 220, hlim 64)
19:05:17.415265 3ffe:8191::2.1044 > 3ffe:80c0:220::b.6667: . [tcp sum ok] 73:73(0) ack 8984 win 17040 (len 20, hlim 60)
19:05:17.415292 3ffe:80c0:220::b.6667 > 3ffe:8191::2.1044: . 8984:10204(1220) ack 73 win 5680 (len 1240, hlim 64)
19:05:17.454987 3ffe:400:1060:1114::5.4818 > 3ffe:80c0:220::b.6667: . [tcp sum ok] 109:109(0) ack 1213 win 32660 (len 20, hlim 60)
19:05:17.455008 3ffe:80c0:220::b.6667 > 3ffe:400:1060:1114::5.4818: P 1213:1860(647) ack 109 win 5680 (len 667, hlim 64)
19:05:17.504433 3ffe:80c0:220::b.6667 > 3ffe:8060:100::24:2.6127: P 31030:32091(1061) ack 131 win 5680 (len 1081, hlim 64)
19:05:17.567873 3ffe:400:680:aaaa::aaaa:15.1117 > 3ffe:80c0:220::b.6667: . [tcp
sum ok] 124:124(0) ack 39890 win 31440 <nop,nop,sack sack 1 {40090:40197} > (len 32, hlim 61)
19:05:17.567951 3ffe:80c0:220::b.6667 > 3ffe:400:680:aaaa::aaaa:15.1117: . 40197:41417(1220) ack 124 win 5680 (len 1240, hlim 64)
19:05:17.567973 3ffe:80c0:220::b.6667 > 3ffe:400:680:aaaa::aaaa:15.1117: . 41417:41617(200) ack 124 win 5680 (len 220, hlim 64)
19:05:17.571274 3ffe:1001:340::6.113 > 3ffe:80c0:220::b.4126: R [tcp sum ok] 0:0(0) ack 2552352897 win 0 (len 20, hlim 61)
19:05:17.571531 3ffe:80c0:220::b.4128 > 3ffe:1001:340::6.1080: S [tcp sum ok] 2567012712:2567012712(0) win 5680 <mss 1420,sackOK,timestamp 11315158 0,nop,wscale 0> (len 40, hlim 64)
19:05:17.572429 3ffe:400:680:aaaa::aaaa:15.1117 > 3ffe:80c0:220::b.6667: P [tcp
sum ok] 124:143(19) ack 39890 win 31440 <nop,nop,sack sack 1 {40090:40197} > (len 51, hlim 61)
19:05:17.572453 3ffe:80c0:220::b.6667 > 3ffe:400:680:aaaa::aaaa:15.1117: . [tcp
sum ok] 41617:41617(0) ack 143 win 5680 (len 20, hlim 64)
19:05:17.664420 3ffe:80c0:220::b.6667 > 3ffe:80c0:220::19.1998: P 5851:6543(692) ack 475 win 5680 (len 712, hlim 64)
19:05:17.667774 3ffe:400:680:11::aaaa:aa15.3452 > 3ffe:80c0:220::b.6667: . [tcp
sum ok] 67:67(0) ack 789 win 48800 (len 20, hlim 60)
19:05:17.667796 3ffe:80c0:220::b.6667 > 3ffe:400:680:11::aaaa:aa15.3452: P 789:2209(1420) ack 67 win 5680 (len 1440, hlim 64)
19:05:17.667809 3ffe:80c0:220::b.6667 > 3ffe:400:680:11::aaaa:aa15.3452: P 2209:2698(489) ack 67 win 5680 (len 509, hlim 64)
19:05:17.672695 3ffe:400:680:11::aaaa:aa15.3452 > 3ffe:80c0:220::b.6667: P [tcp
sum ok] 67:85(18) ack 789 win 48800 (len 38, hlim 60)
19:05:17.672707 3ffe:80c0:220::b.6667 > 3ffe:400:680:11::aaaa:aa15.3452: . [tcp
sum ok] 2698:2698(0) ack 85 win 5680 (len 20, hlim 64)
19:05:17.704419 3ffe:80c0:220::b.6667 > 3ffe:80e8:140:200::1.3899: P 158:1049(891) ack 85 win 5680 (len 911, hlim 64)
19:05:17.787623 3ffe:b00:4011:a::3.1880 > 3ffe:80c0:220::b.6667: P [tcp sum ok]
213:232(19) ack 1163 win 17080 (len 39, hlim 61)
19:05:17.787646 3ffe:80c0:220::b.6667 > 3ffe:b00:4011:a::3.1880: P 2383:3603(1220) ack 232 win 5680 (len 1240, hlim 64)
19:05:17.787661 3ffe:80c0:220::b.6667 > 3ffe:b00:4011:a::3.1880: P 3603:4789(1186) ack 232 win 5680 (len 1206, hlim 64)
19:05:17.831030 3ffe:401:0:1::16:2 > 3ffe:80c0:220::b: icmp6: too big 1280
 (len 1240, hlim 63)
19:05:17.831059 3ffe:80c0:220::b.6667 > 3ffe:400:680:11::aaaa:aa15.3452: . 789:2009(1220) ack 85 win 5680 (len 1240, hlim 64)
19:05:17.834164 3ffe:1001:211:80:baba:beba:deca:ceca.33258 > 3ffe:80c0:220::b.6667: . [tcp sum ok] 290:290(0) ack 10889 win 29280 <nop,nop,sack sack 1 {11927:13347} > (len 32, hlim 60)
19:05:17.857380 3ffe:400:680:aaaa::aaaa:15.1117 > 3ffe:80c0:220::b.6667: . [tcp
sum ok] 143:143(0) ack 40197 win 31240 <nop,nop,sack sack 1 {41417:41617} > (len 32, hlim 61)
19:05:17.857402 3ffe:80c0:220::b.6667 > 3ffe:400:680:aaaa::aaaa:15.1117: . 41617:42837(1220) ack 143 win 5680 (len 1240, hlim 64)
19:05:17.857413 3ffe:80c0:220::b.6667 > 3ffe:400:680:aaaa::aaaa:15.1117: P 42837:43037(200) ack 143 win 5680 (len 220, hlim 64)
19:05:17.886139 3ffe:400:1060:1114::5.4818 > 3ffe:80c0:220::b.6667: . [tcp sum ok] 109:109(0) ack 1860 win 32660 (len 20, hlim 60)
19:05:17.934013 3ffe:8191::2.1044 > 3ffe:80c0:220::b.6667: . [tcp sum ok] 73:73(0) ack 10204 win 17040 (len 20, hlim 60)
19:05:17.934031 3ffe:80c0:220::b.6667 > 3ffe:8191::2.1044: P 10204:10404(200) ack 73 win 5680 (len 220, hlim 64)
19:05:17.943394 3ffe:8060:100::24:2.6127 > 3ffe:80c0:220::b.6667: . [tcp sum ok] 131:131(0) ack 32091 win 17080 (len 20, hlim 60)
19:05:17.943413 3ffe:80c0:220::b.6667 > 3ffe:8060:100::24:2.6127: P 32091:33311(1220) ack 131 win 5680 (len 1240, hlim 64)
19:05:17.943426 3ffe:80c0:220::b.6667 > 3ffe:8060:100::24:2.6127: P 33311:34531(1220) ack 131 win 5680 (len 1240, hlim 64)
19:05:17.950817 3ffe:b00:4011:a::3.1880 > 3ffe:80c0:220::b.6667: . [tcp sum ok]
232:232(0) ack 2383 win 17080 (len 20, hlim 61)
19:05:17.965314 3ffe:200:40::3.4010 > 3ffe:80c0:220::b.6667: P [tcp sum ok] 248:264(16) ack 13106 win 32660 (len 36, hlim 61)
19:05:17.965335 3ffe:80c0:220::b.6667 > 3ffe:200:40::3.4010: . [tcp sum ok] 13143:13143(0) ack 264 win 5680 <nop,nop,sack sack 1 {248:264} > (len 32, hlim 64)
19:05:17.971414 3ffe:400:680:11::aaaa:aa15.3452 > 3ffe:80c0:220::b.6667: . [tcp
sum ok] 85:85(0) ack 789 win 48800 <nop,nop,sack sack 1 {2209:2698} > (len 32, hlim 60)
19:05:17.971428 3ffe:80c0:220::b.6667 > 3ffe:400:680:11::aaaa:aa15.3452: P 2009:2209(200) ack 85 win 5680 (len 220, hlim 64)
19:05:18.013093 3ffe:80c0:220::19.1998 > 3ffe:80c0:220::b.6667: . [tcp sum ok] 475:475(0) ack 6543 win 19520 <nop,nop,sack sack 1 {5851:6543} > (len 32, hlim 63)

More of the tcpdump is available upon request.


Kurt

