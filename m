Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266749AbUJVScr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266749AbUJVScr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 14:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUJVS1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 14:27:33 -0400
Received: from mproxy.gmail.com ([216.239.56.244]:9009 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266914AbUJVSVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 14:21:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=RGQ7oafkqUCz2wra2y6f4Ao+cdY+XYBf5fq/insjrEWqJMz97bwZRgusfzRqbOnSOH5SW5j3Ggt/x+rWWOXydx0Ev42N5TiinBOICoRK2zC+yGmv0QLA+WH8zMd49IKGCG+j382IAEeMiBw0GLAHcuzWzY4nM58bQhxDsYew4dM=
Message-ID: <90c25f2704102211212031af71@mail.gmail.com>
Date: Fri, 22 Oct 2004 23:51:22 +0530
From: Arvind Kalyan <base16@gmail.com>
Reply-To: Arvind Kalyan <base16@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: GPRS on Linux fails due to 255.255.255.255 remote address.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to use my Airtel GPRS connection under Linux.


Status: pppd refuses connection due to improper remote IP address
(255.255.255.255)

(what puzzles me: Why on earth would someone use that as an IP address?)

What I did to get GPRS working:

1. Checked for the following details from Windows XP:

a. modem initialization strings
b. authentication type : pap
c. remote IP address: 255.255.255.255
d. gateway address: my own IP is made my gw (10.*.*.*)
e. name servers: automatically assigned numbers...

2. Rebooted into Linux

SuSE Linux 9.1 vanilla kernel (2.6.4-52-default)


3. Ran wvdialconf to see if phone is detected.

GPRS modem (LG G3100 model) was detected at ttyS0

4. Set up ppp options to allow 
defaultroute, 
noauth, 
ipcp-accept-local (and -remote)

Among others that are common.

5. Dialed (tried both direct pppd invocation and through wvdial)

=========================================================
Content of /var/log/messages (without debug)
pppd[14315]: pppd 2.4.2 started by root, uid 0
pppd[14315]: Using interface ppp0
pppd[14315]: Connect: ppp0 <--> /dev/ttyS0
kernel: PPP BSD Compression module registered
kernel: PPP Deflate Compression module registered
pppd[14315]: appear to have received our own echo-reply!
pppd[14315]: Peer is not authorized to use remote address 255.255.255.255
pppd[14315]: Connection terminated.
pppd[14315]: Connect time 0.1 minutes.
pppd[14315]: Sent 97 bytes, received 64 bytes.
pppd[14315]: Connect time 0.1 minutes.
pppd[14315]: Sent 97 bytes, received 64 bytes.
pppd[14315]: Exit.

=========================================================
The thing about "our own echo reply" is to do with GPRS modems - they
don't respond to "hey modem, are you still alive?" queries.
=========================================================
Content of /var/log/messages (with debug)
pppd[4999]: Using interface ppp0
pppd[4999]: Connect: ppp0 <--> /dev/ttyS0
pppd[4999]: sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0x17caa03d>
<pcomp> <accomp>]
pppd[4999]: rcvd [LCP ConfReq id=0x2d <mru 1600> <auth pap> <magic
0x5fb8dec7> <asyncmap 0x0> <pcomp> <accomp>]
pppd[4999]: sent [LCP ConfNak id=0x2d <auth eap>]
pppd[4999]: rcvd [LCP ConfReq id=0x2e <mru 1600> <auth pap> <magic
0x5fb8dec7> <asyncmap 0x0> <pcomp> <accomp>]
pppd[4999]: sent [LCP ConfNak id=0x2e <auth eap>]
pppd[4999]: rcvd [LCP ConfReq id=0x2f <mru 1600> <auth pap> <magic
0x5fb8dec7> <asyncmap 0x0> <pcomp> <accomp>]
pppd[4999]: sent [LCP ConfNak id=0x2f <auth eap>]
pppd[4999]: rcvd [LCP ConfReq id=0x30 <mru 1600> <auth pap> <magic
0x5fb8dec7> <asyncmap 0x0> <pcomp> <accomp>]
pppd[4999]: sent [LCP ConfNak id=0x30 <auth eap>]
pppd[4999]: rcvd [LCP ConfReq id=0x31 <mru 1600> <auth pap> <magic
0x5fb8dec7> <asyncmap 0x0> <pcomp> <accomp>]
pppd[4999]: sent [LCP ConfNak id=0x31 <auth eap>]
pppd[4999]: rcvd [LCP ConfReq id=0x32 <mru 1600> <auth pap> <magic
0x5fb8dec7> <asyncmap 0x0> <pcomp> <accomp>]
pppd[4999]: sent [LCP ConfRej id=0x32 <auth pap>]
pppd[4999]: rcvd [LCP ConfReq id=0x33 <mru 1600> <magic 0x5fb8dec7>
<asyncmap 0x0> <pcomp> <accomp>]
pppd[4999]: sent [LCP ConfAck id=0x33 <mru 1600> <magic 0x5fb8dec7>
<asyncmap 0x0> <pcomp> <accomp>]
pppd[4999]: sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0x17caa03d>
<pcomp> <accomp>]
pppd[4999]: rcvd [LCP ConfAck id=0x1 <asyncmap 0x0> <magic 0x17caa03d>
<pcomp> <accomp>]
pppd[4999]: sent [LCP EchoReq id=0x0 magic=0x17caa03d]
pppd[4999]: sent [CCP ConfReq id=0x1 <deflate 15> <deflate(old#) 15>
<bsd v1 15>]
pppd[4999]: sent [IPCP ConfReq id=0x1 <compress VJ 0f 01> <addr
0.0.0.0> <ms-dns1 0.0.0.0> <ms-dns3 0.0.0.0>]
pppd[4999]: rcvd [LCP EchoRep id=0x0 magic=0x17caa03d]
pppd[4999]: appear to have received our own echo-reply!
pppd[4999]: rcvd [LCP ProtRej id=0x9 80 fd a4 d9 05 08]
pppd[4999]: rcvd [IPCP ConfRej id=0x1 <compress VJ 0f 01>]
pppd[4999]: sent [IPCP ConfReq id=0x2 <addr 0.0.0.0> <ms-dns1 0.0.0.0>
<ms-dns3 0.0.0.0>]
pppd[4999]: rcvd [IPCP ConfReq id=0x8 <addr 255.255.255.255>]
pppd[4999]: sent [IPCP ConfAck id=0x8 <addr 255.255.255.255>]
pppd[4999]: rcvd [IPCP ConfNak id=0x2 <addr 10.151.104.192> <ms-dns1
202.56.250.5> <ms-dns3 202.56.250.6>]
pppd[4999]: sent [IPCP ConfReq id=0x3 <addr 10.151.104.192> <ms-dns1
202.56.250.5> <ms-dns3 202.56.250.6>]
pppd[4999]: rcvd [IPCP ConfAck id=0x3 <addr 10.151.104.192> <ms-dns1
202.56.250.5> <ms-dns3 202.56.250.6>]
pppd[4999]: Peer is not authorized to use remote address 255.255.255.255
pppd[4999]: sent [IPCP TermReq id=0x4 "Unauthorized remote IP address"]
pppd[4999]: rcvd [IPCP TermAck id=0x4]
pppd[4999]: sent [LCP TermReq id=0x2 "No network protocols running"]
pppd[4999]: rcvd [LCP TermAck id=0x2]
pppd[4999]: Connection terminated.
pppd[4999]: Connect time 0.1 minutes.
pppd[4999]: Sent 97 bytes, received 64 bytes.
pppd[4999]: Connect time 0.1 minutes.
pppd[4999]: Sent 97 bytes, received 64 bytes.
pppd[4999]: Exit.
=========================================================

6. Tried a few things to "force" it to accept.

a. Edited pap&chap-secrets to "allow" 255.255.255.255

Result: no changes in response.

b. Edited pppd/ipcp.c to disable authentication

if (!auth_ip_addr(f->unit, ho->hisaddr)) {
        error("Peer is not authorized to use remote address %I", ho->hisaddr);
           ipcp_close(f->unit, "Unauthorized remote IP address");
           return;
        }

The above code snippet, which checks the authentication, was commented
out, so I can make the peer use the IP address without
"authentication".

(ps: This was necessary as adding an entry for the IP in pap-secrets
and chap-secrets had no effect on the error message.)

Result: fails when trying to set 255.255.255.255 as remote interface's
address (ioctl failure)

c. Edited pppd/sys-linux.c to set gateway ip=local ip

- SIN_ADDR(ifr.ifr_dstaddr) = his_adr;
+ SIN_ADDR(ifr.ifr_dstaddr) = our_adr;

Result: connection established. But, routing failed miserably. I was
not able to add a `route` so I could do virtually nothing with the
ppp0 link. Because nothing was reachable. (Obvious! But I gave it a
shot)

7. Called Airtel to know what protocol they were using so I can figure
out how to set it up.

Result: they didn't know what they were using on their side.

----------------------------------------------------

If anyone has further information which you think could be of some
help, kindly share. I'd appreciate it.

Thanks!



-- 
Arvind Kalyan
CS Engineering Student. Mobile: (+91)98940 9 345 9
