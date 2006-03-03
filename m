Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWCCKdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWCCKdh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 05:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWCCKdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 05:33:37 -0500
Received: from zaz.kom.auc.dk ([130.225.51.10]:56008 "EHLO zaz.kom.auc.dk")
	by vger.kernel.org with ESMTP id S1751266AbWCCKdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 05:33:36 -0500
Message-ID: <44081B7B.5060104@kom.aau.dk>
Date: Fri, 03 Mar 2006 11:33:31 +0100
From: Oumer Teyeb <oumer@kom.aau.dk>
Reply-To: Oumer Teyeb <oumer@kom.aau.dk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Oumer Teyeb <oumer@kom.aau.dk>
Subject: TCP control block interdependence
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am not sure if it is the right place to post this but people at
comp.protocols.tcp-ip, comp.os.linux.networking suggested it.
Could you please cc the reply to oumer@kom.auc.dk?

as a part of my studies I have to investigate some link layer protocol 
impacts on TCP performance...so I have some emulator working on linux, 
and I was investigating the impact of delay spikes....

I results I am getting are a little bit wierd and I think it is mainly 
due to TCP control block interdependence implementation in linux....

EXPERIMENT ILLUSTRATING THE PROBLEM
=======================================

I downloaded a 100K file using FTP over a 384kbps connection...and I 
introduce a delay of 10 sec, 2 seconds after the download starts..

case 1)
I did four downloads immediatley after each other

case 2)
I did four downloads but this time, I wait ten mintues before the next 
download

results)
Case 1) I have a lot of retransmissions in the first one (because of the 
10sec gap)..but the rest dont seem to suffer from retransmission at all, 
even during the 10sec gap...the rtt values confirm it ..i,e. in the 
first case, the rtt curve shows the RTT values are mostly below 1 
sec..while in the next three downloads, the RTTs are sometimes more than 
10sec....showing that the RTO value used for the three cases is 
something different than the first one
curves can be found at :tsg=time sequence graph
http://kom.auc.dk/~oumer/case1_1_tsg.ps
http://kom.auc.dk/~oumer/case1_1_rtt.ps
http://kom.auc.dk/~oumer/case1_2_tsg.ps
http://kom.auc.dk/~oumer/case1_2_rtt.ps
http://kom.auc.dk/~oumer/case1_3_tsg.ps
http://kom.auc.dk/~oumer/case1_3_rtt.ps
http://kom.auc.dk/~oumer/case1_4_tsg.ps
http://kom.auc.dk/~oumer/case1_4_rtt.ps

Case 2) There is almost no different between the four downloads
http://kom.auc.dk/~oumer/case2_1_tsg.ps
http://kom.auc.dk/~oumer/case2_1_rtt.ps
http://kom.auc.dk/~oumer/case2_2_tsg.ps
http://kom.auc.dk/~oumer/case2_2_rtt.ps
http://kom.auc.dk/~oumer/case2_3_tsg.ps
http://kom.auc.dk/~oumer/case2_3_rtt.ps
http://kom.auc.dk/~oumer/case2_4_tsg.ps
http://kom.auc.dk/~oumer/case2_4_rtt.ps

 From these I conclude that there is some TCP congestion control and 
retransmission parameter caching, that is also time dependant....
and I want to disable it completley...

So in short do you know how to disable this control block interdepence? 
I am doing experiments related to some link layer issues, and any 
dependancy between two consecutive connections to the same host is 
seriously biasing my results..and to get statistical measures, I have to 
do the runs hundrends of times, under different conditions, so I cant 
afford to wait several minutes between consecutive runs (to make sure 
control block interdependence is not at work)...so maybe there is a way 
to trick linux tcp not to apply interdependence?

In the Linux congestion control paper by Pasi Sarlhoti, "Congestion 
Control in Linux TCP" it is mentioned that "the Linux destination cache 
provides functionality similar to the RFC 2140 that proposes Control 
Block Interdependence between the TCP connections." but there was no 
additional details...

in 
http://www.cs.helsinki.fi/research/iwtcp/kernel-patch/README-2.4.18-frto-20020419.txt
I found some text where there is a patch that will make it possible to 
control the interdependence setting..but I am using some servers at our 
university, and I dont think the admins will be willing to install 
patches that are not stable....
how stable is this patch? and have anyone been using it?
Is there another simple way like setting some default values in some 
headers and recompiling the kernel, maybe the admins will be willing to 
do that for me in some servers (I am not that familiar the linux kernel, 
and I have to admit I had never recompiled/"messed" with it...)

by the way I am using debian linux distribution and "uname -a" gives me
Linux 2.4.25-std #1 SMP Mon Mar 22 10:25:51 CET 2004 i686 unknown

Thanks in advance,
Oumer Teyeb
