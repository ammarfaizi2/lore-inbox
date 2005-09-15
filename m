Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965262AbVIOF0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965262AbVIOF0k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 01:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965265AbVIOF0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 01:26:40 -0400
Received: from mail2.sasken.com ([203.200.200.72]:54765 "EHLO mail2.sasken.com")
	by vger.kernel.org with ESMTP id S965262AbVIOF0j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 01:26:39 -0400
From: "Mahesh" <mahesh@sasken.com>
To: <linux-kernel@vger.kernel.org>
Subject: IPPPd  incoming channel bundling issue.
Date: Thu, 15 Sep 2005 10:56:31 +0530
Message-ID: <MGECKBKGMOMHMJKIKHAMIEPKCKAA.mahesh@sasken.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_07EA_01C5B9E4.212D5BF0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-imss-version: 2.030
X-imss-result: Passed
X-imss-scores: Clean:85.20626 C:2 M:3 S:5 R:5
X-imss-settings: Baseline:3 C:3 M:3 S:3 R:3 (0.5000 0.5000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_07EA_01C5B9E4.212D5BF0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


Hi,
We are using IPPPd open source package for ISDN connection and it is working
fine. The problem we are facing is with channel bundling for incoming calls.
I am adding ippp0 to ippp15 channels as Master interfaces. But when there is
an incoming call to my system and the dial-in user wants to do channel
bundling this is not happening. To support this I added the ippp14, ippp13,
ippp12 as slave devices to ippp15 master device. This resolves the channel
bundling issue for the 4 incoming calls which needs to be bundled but it is
creating some other problem. Suppose one user is dialing in to my system and
user is using two channels both the calls are answered and bundled(ippp15
and ippp14). Now another user is dialing in to my system and ippp13
answered. This call is not bundled(as expected) but it is assigning the same
IP address of master interface(ippp15). So the IP address is same for the
first call(with channel bundling) and for the second call. Can you please
let me know whether IPPPd supports assigning different IP address if there
is no channel bundling for the slave interface. This is really required
feature for the IPPPd where it can act as server also and I hope this is
already supporting. Please find the attached script file which I am using
for adding the ippp12, ippp13, ippp14 as slave devices to ippp15 master
device and the options file.


Thanks,
Mahesh.


"SASKEN RATED THE BEST EMPLOYER IN THE COUNTRY by the BUSINESS TODAY Mercer Survey 2004"


                           SASKEN BUSINESS DISCLAIMER
This message may contain confidential, proprietary or legally Privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, Disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email
------=_NextPart_000_07EA_01C5B9E4.212D5BF0
Content-Type: application/octet-stream;
	name="isdndialin15.up"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="isdndialin15.up"

#!/bin/sh=0A=
#=0A=
# don't forget to edit the files=0A=
#     /etc/ppp/pap-secrets or=0A=
#     /etc/ppp/chap-secrets=0A=
#=0A=
=0A=
DEVICE=3D"ippp15"=0A=
=0A=
# additional for channel bundling:=0A=
DEVICE1=3D"ippp14"=0A=
DEVICE2=3D"ippp13"=0A=
DEVICE3=3D"ippp12"=0A=
=0A=
VERSION=3D`cat /proc/version | awk '{ print $3 }' `=0A=
=0A=
isdnctrl addif  $DEVICE                 # Create new interface 'DEVICE'=0A=
isdnctrl eaz $DEVICE B***               #Set local EAZ ..=0A=
isdnctrl l2_prot $DEVICE hdlc           # for sync PPP: set Level 2 to =
HDLC=0A=
isdnctrl l3_prot $DEVICE trans          # not really necessary, 'trans' =
is default=0A=
isdnctrl encap $DEVICE syncppp          # encap the IP Pakets in PPP =
frames=0A=
isdnctrl huptimeout $DEVICE 300         # Hangup-Timeout is 300 sec. -> =
5 min=0A=
isdnctrl chargehup $DEVICE off          # Hangup before next Charge-Info=0A=
isdnctrl secure $DEVICE off             # Accept only configured =
phone-number=0A=
=0A=
# additional for channel bundling:=0A=
isdnctrl addslave $DEVICE $DEVICE1      # Create new slave interface =
'DEVICE1'=0A=
isdnctrl eaz $DEVICE1 B***              # Set local EAZ ..=0A=
isdnctrl l2_prot $DEVICE1 hdlc          # for sync PPP: set Level 2 to =
HDLC=0A=
isdnctrl l3_prot $DEVICE1 trans         # not really necessary, 'trans' =
is default=0A=
isdnctrl encap $DEVICE1 syncppp         # encap the IP Pakets in PPP =
frames=0A=
isdnctrl huptimeout $DEVICE1 300        # Hangup-Timeout is 300 sec. -> =
5 min=0A=
isdnctrl chargehup $DEVICE1 off         # Hangup before next Charge-Info=0A=
isdnctrl secure $DEVICE1 off            #Accept only configured =
phone-number=0A=
=0A=
=0A=
isdnctrl addslave $DEVICE $DEVICE2      # Create new slave interface =
'DEVICE1'=0A=
isdnctrl eaz $DEVICE2 B***              # Set local EAZ ..=0A=
isdnctrl l2_prot $DEVICE2 hdlc          # for sync PPP: set Level 2 to =
HDLC=0A=
isdnctrl l3_prot $DEVICE2 trans         # not really necessary, 'trans' =
is default=0A=
isdnctrl encap $DEVICE2 syncppp         # encap the IP Pakets in PPP =
frames=0A=
isdnctrl huptimeout $DEVICE2 300        # Hangup-Timeout is 300 sec. -> =
5 min=0A=
isdnctrl chargehup $DEVICE2 off         # Hangup before next Charge-Info=0A=
isdnctrl secure $DEVICE2 off            # Accept only configured =
phone-number=0A=
=0A=
=0A=
isdnctrl addslave $DEVICE $DEVICE3      # Create new slave interface =
'DEVICE1'=0A=
isdnctrl eaz $DEVICE3 B***              # Set local EAZ ..=0A=
isdnctrl l2_prot $DEVICE3 hdlc          # for sync PPP: set Level 2 to =
HDLC=0A=
isdnctrl l3_prot $DEVICE3 trans         # not really necessary, 'trans' =
is default=0A=
isdnctrl encap $DEVICE3 syncppp         # encap the IP Pakets in PPP =
frames=0A=
isdnctrl huptimeout $DEVICE3 300        # Hangup-Timeout is 300 sec. -> =
5 min=0A=
isdnctrl chargehup $DEVICE3 off         # Hangup before next Charge-Info=0A=
isdnctrl secure $DEVICE3 off            # Accept only configured =
phone-number=0A=
=0A=
=0A=
ifconfig ippp15 10.11.16.33 pointopoint 10.11.16.34  =0A=
#route add default $DEVICE=0A=
#route add default gw 10.11.11.3=0A=
=0A=
ipppd /dev/ippp15 /dev/ippp14 /dev/ippp13 /dev/ippp12 file =
/nn/etc/ppp/isdn/DialIn_ioptions/ioptions.ippp15 pidfile =
/var/run/ipppd.ippp15.pid &=0A=
=0A=
=0A=

------=_NextPart_000_07EA_01C5B9E4.212D5BF0
Content-Type: application/octet-stream;
	name="ioptions.ippp15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ioptions.ippp15"

+mp=0A=
noipdefault =0A=
auth =0A=
+pap=0A=
+chap=0A=
-ac=0A=
mru 1500=0A=
mtu 1500=0A=
10.11.16.33:10.11.16.34=0A=
lock=0A=
defaultroute=0A=
netmask 255.255.255.255=0A=
=0A=

------=_NextPart_000_07EA_01C5B9E4.212D5BF0--


