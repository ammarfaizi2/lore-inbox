Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131990AbRAOFU4>; Mon, 15 Jan 2001 00:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132203AbRAOFUq>; Mon, 15 Jan 2001 00:20:46 -0500
Received: from kamov.deltanet.ro ([193.226.175.3]:21766 "HELO
	kamov.deltanet.ro") by vger.kernel.org with SMTP id <S131990AbRAOFUk>;
	Mon, 15 Jan 2001 00:20:40 -0500
Date: Mon, 15 Jan 2001 07:20:26 +0200
From: Petru Paler <ppetru@ppetru.net>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-pre3+zerocopy: weird messages
Message-ID: <20010115072026.A918@ppetru.net>
In-Reply-To: <20010114121105.B1394@ppetru.net> <14945.32886.671619.99921@pizda.ninka.net> <20010114124549.D1394@ppetru.net> <14945.34414.185794.396720@pizda.ninka.net> <20010114132845.F1394@ppetru.net> <14945.36440.59585.376942@pizda.ninka.net> <20010114141003.G1394@ppetru.net> <20010114151257.J1394@ppetru.net> <14945.42973.905573.579075@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
In-Reply-To: <14945.42973.905573.579075@pizda.ninka.net>; from davem@redhat.com on Sun, Jan 14, 2001 at 05:21:33AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2001 at 05:21:33AM -0800, David S. Miller wrote:
> Petru Paler writes:
>  > Got more "udp v4 hw csum failure" messages but still no "UDP packet
>  > with bad csum was fragmented".
> 
> OK, last experiment :-)  Add this patch, and watch to see if
> the UDP "InErrors" field in /proc/net/snmp has a non-zero value after
> letting it run for a while.  Thanks.

Ok, here it is:

grey:/proc/net# uptime
 12:14am  up 11:01,  1 user,  load average: 0.45, 0.47, 0.41
grey:/proc/net# cat snmp
Ip: Forwarding DefaultTTL InReceives InHdrErrors InAddrErrors ForwDatagrams InUnknownProtos InDiscards InDelivers OutRequests OutDiscards OutNoRoutes ReasmTimeout ReasmReqds ReasmOKs ReasmFails FragOKs FragFails FragCreates
Ip: 2 64 8340770 0 0 0 0 8 8290517 1359445 6 0 0 0 0 0 0 0 0
Icmp: InMsgs InErrors InDestUnreachs InTimeExcds InParmProbs InSrcQuenchs InRedirects InEchos InEchoReps InTimestamps InTimestampReps InAddrMasks InAddrMaskReps OutMsgs OutErrors OutDestUnreachs OutTimeExcds OutParmProbs OutSrcQuenchs OutRedirects OutEchos OutEchoReps OutTimestamps OutTimestampReps OutAddrMasks OutAddrMaskReps
Icmp: 7370 446 3846 772 0 39 0 2708 0 0 0 0 0 9661 0 6953 0 0 0 0 0 2708 0 0 0 0
Tcp: RtoAlgorithm RtoMin RtoMax MaxConn ActiveOpens PassiveOpens AttemptFails EstabResets CurrEstab InSegs OutSegs RetransSegs InErrs OutRsts
Tcp: 0 0 0 0 16025 0 128 0 20 825925 921717 44521 189 28300
Udp: InDatagrams NoPorts InErrors OutDatagrams
Udp: 7500511 6953 30 428614

--
Petru Paler, mailto:ppetru@ppetru.net
http://www.ppetru.net - ICQ: 41817235
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
