Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269602AbUINRSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269602AbUINRSj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 13:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269473AbUINRPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 13:15:53 -0400
Received: from hermes.uci.kun.nl ([131.174.93.58]:64385 "EHLO
	hermes.uci.kun.nl") by vger.kernel.org with ESMTP id S269530AbUINRMj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:12:39 -0400
Date: Tue, 14 Sep 2004 19:10:57 +0200
From: Arnout Engelen <arnouten@bzzt.net>
X-Face: .NTzn{Sdm0J?lRrT!!ZlD*F.4iAkyy+A$,QfVsVBz.,k4QFi66b]ykR.Y..HR{OM>4b,9..
 |we.b[Oi![,fv-=7w.oRq>9.HIi$7.P*nSW=3p&*r91H=_h,b.4<C'oSg2eUfHPO8%wVoP^i_TyAZ.
 h0I(cIjB=..hc436%E(QM.Qg[z~|]7.5-X>s.X*caTn}0NY"A.q<+[wb~N2
Subject: /proc/net/tcp documentation
To: linux-kernel@vger.kernel.org
Message-id: <20040914171057.GF11646@bzzt.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary=kORqDWCi7qDJ0mEj
Content-disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I noticed there doesn't seem to be any documentation for /proc/net/tcp,
so i whipped up the attached description.=20

Maybe someone could add this to /Documentation/networking? I wrote it
for 2.4.26, but the code doesn't seem to have changed relevantly since
then.


(please cc me in replies as i won't be constantly monitoring the list)

Kind regards,

--=20
Arnout Engelen <arnouten@bzzt.net>

  "If it sounds good, it /is/ good."
          -- Duke Ellington

--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=procnettcp
Content-Transfer-Encoding: quoted-printable

/proc/net/tcp and /proc/net/tcp6

These /proc interfaces provide information about currently active TCP=20
connections, and are implemented by tcp_get_info() in net/ipv4/tcp_ipv4.c a=
nd
tcp6_get_info() in net/ipv6/tcp_ipv6.c, respectively.

It will first list all listening TCP sockets, and next list all established
TCP connections. A typical entry of /proc/net/tcp would look like this (spl=
it=20
up into 3 parts because of the length of the line):

   46: 010310AC:9C4C 030310AC:1770 01=20
   |      |      |      |      |   |--> connection state
   |      |      |      |      |------> remote TCP port number
   |      |      |      |-------------> remote IPv4 address
   |      |      |--------------------> local TCP port number
   |      |---------------------------> local IPv4 address
   |----------------------------------> number of entry

   00000150:00000000 01:00000019 00000000 =20
      |        |     |     |       |--> number of unrecovered RTO timeouts
      |        |     |     |----------> number of jiffies until timer expir=
es
      |        |     |----------------> timer_active (see below)
      |        |----------------------> receive-queue
      |-------------------------------> transmit-queue

   1000        0 54165785 4 cd1e6040 25 4 27 3 -1
    |          |    |     |    |     |  | |  | |--> slow start size thresho=
ld,=20
    |          |    |     |    |     |  | |  |      or -1 if the treshold
    |          |    |     |    |     |  | |  |      is >=3D 0xFFFF
    |          |    |     |    |     |  | |  |----> sending congestion wind=
ow
    |          |    |     |    |     |  | |-------> (ack.quick<<1)|ack.ping=
pong
    |          |    |     |    |     |  |---------> Predicted tick of soft =
clock
    |          |    |     |    |     |              (delayed ACK control da=
ta)
    |          |    |     |    |     |------------> retransmit timeout
    |          |    |     |    |------------------> location of socket in m=
emory
    |          |    |     |-----------------------> socket reference count
    |          |    |-----------------------------> inode
    |          |----------------------------------> unanswered 0-window pro=
bes
    |---------------------------------------------> uid

timer_active:
  0  no timer is pending
  1  retransmit-timer is pending
  2  another timer (e.g. delayed ack or keepalive) is pending
  3  this is a socket in TIME_WAIT state. Not all field will contain data.
  4  zero window probe timer is pending

--kORqDWCi7qDJ0mEj--
