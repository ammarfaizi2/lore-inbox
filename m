Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131423AbQKJSt4>; Fri, 10 Nov 2000 13:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130807AbQKJStq>; Fri, 10 Nov 2000 13:49:46 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:54285 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131391AbQKJStd>; Fri, 10 Nov 2000 13:49:33 -0500
Message-ID: <3A0C4252.100D863D@timpanogas.org>
Date: Fri, 10 Nov 2000 11:45:39 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Fwd: sendmail fails to deliver mail with attachments in 
 /var/spool/mqueue]
Content-Type: multipart/mixed;
 boundary="------------6F053B7B32D5A229ABFC201C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6F053B7B32D5A229ABFC201C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


The sendmail folks are claiming that the TCPIP stack in Linux is broken,
which is what they claim is causing problems on sendmail on Linux
platforms.  Before anyone says, "don't use that piece of shit sendmail,
use qmail instead", perhaps we should look at this problem and refute
these statements -- I think that sendmail is causing this problem.  The
version is sendmail 8.9.3

I can reproduce this bug on RH6.2, RH7.0, Caldera 2.2, 2.3, and 2.4,
Suse 6.X versions, and any of these distributions with the following
kernels.   

2.2.14, 2.2.16, 2.2.17, 2.2.18, 2.4.0 (all).  What happens is that
sendmail fails to forward mails with any attachments larger than 400K,
and they just sit in the /var/spool/mqueue directory for up to a week,
and eventually get delivered.

ANyone have any ideas if what the sendmail people are saying is on the
level, or is this just another sendmail bug.  

Jeff
--------------6F053B7B32D5A229ABFC201C
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

X-Mozilla-Status2: 00000000
Message-ID: <3A0C3F30.F5EB076E@timpanogas.org>
Date: Fri, 10 Nov 2000 11:32:16 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: sendmail-bugs@sendmail.org
Subject: Re: sendmail fails to deliver mail with attachments in /var/spool/mqueue
In-Reply-To: <3A0C427A.E015E58A@timpanogas.org> <20001110095227.A15010@sendmail.com> <3A0C37FF.23D7B69@timpanogas.org> <20001110101138.A15087@sendmail.com>
Content-Type: multipart/mixed;
 boundary="------------EF65FD30FD900E62CDD3651A"

This is a multi-part message in MIME format.
--------------EF65FD30FD900E62CDD3651A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Claus,

Here's the output from mailq -v and ps -ax.  As you can see, sendmail is
seriously malfunctining.  I have seen this same bug accross three
platforms with a wide variety 
of linux kernels from 2.2.14 to 2.2.18 to 2.4.0-10.  This is your bug,
and noone else's.

How do we get it fixed or is it possibly a configuration error.

Jeff

Claus Assmann wrote:
> 
> On Fri, Nov 10, 2000, Jeff V. Merkey wrote:
> >
> >
> > Claus Assmann wrote:
> > >
> > > On Fri, Nov 10, 2000, root wrote:
> > > >
> > > > I am seeimg sendmail 8.9.3 fail to deliver emails in /var/spool/mqueue
> > > > with attachements for up to a week.  Issuing the command "sendmail -v
> > > > -q" does not flush the mail queue.
> > >
> > > Is the queue item locked? What happens when you try to run it?
> >
> > How do I tell if the queue item is locked.  If you have a web browser, I
> 
> mailq -v
> look for a '*' next to the id.
> 
> > am running
> > webmin on the box and I have setup an account so you can come in and see
> > the mail queue yourself.
> >
> > enter www.timpanogas.org:10000 as your URL, then login as
> > username "sendmail" and password "sendmailbugs".   I will disable this
> 
> I don't know webmin, but most of the entries say "sending".  So
> check your sendmail processes to see what they are doing.  There
> might be some Linux TCP/IP stack bug that causes the problem (no
> proper timeout). For that you need to use trace/truss to see where
> the processes hang and how old they are.
> 
> I couldn't see any local delivery or very old entries.
--------------EF65FD30FD900E62CDD3651A
Content-Type: text/plain; charset=us-ascii;
 name="ps.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ps.txt"

  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:06 init [3]
    2 ?        SW     0:00 [kflushd]
    3 ?        SW     0:01 [kupdate]
    4 ?        SW     0:00 [kpiod]
    5 ?        SW     0:00 [kswapd]
   95 ?        S      0:00 /sbin/modprobe -s -k nwfs
   96 ?        D      0:00 /sbin/modprobe -s -k nwfs
   97 ?        D      0:00 /sbin/modprobe -s -k nwfs
   98 ?        D      0:18 /sbin/modprobe -s -k nwfs
   99 ?        D      0:00 /sbin/modprobe -s -k nwfs
  100 ?        D      0:05 /sbin/modprobe -s -k nwfs
  101 ?        D      0:00 /sbin/modprobe -s -k nwfs
  102 ?        D      0:00 /sbin/modprobe -s -k nwfs
  103 ?        D      0:00 /sbin/modprobe -s -k nwfs
  104 ?        D      0:00 /sbin/modprobe -s -k nwfs
  105 ?        D      0:00 /sbin/modprobe -s -k nwfs
  344 ?        S      0:00 portmap
  367 ?        S      0:00 rpc.statd
  390 ?        S      0:00 /usr/sbin/automount /misc file /etc/auto.misc
  405 ?        S      0:00 /usr/sbin/apmd -p 10 -w 5 -W -s /etc/sysconfig/apm-sc
  456 ?        S      0:19 syslogd -m 0
  465 ?        S      0:00 klogd
  479 ?        S      0:00 identd -e -o
  483 ?        S      0:00 identd -e -o
  484 ?        S      0:00 identd -e -o
  485 ?        S      0:00 identd -e -o
  486 ?        S      0:00 identd -e -o
  497 ?        S      0:00 /usr/sbin/atd
  511 ?        S      0:00 crond
  529 ?        S      0:01 inetd
  543 ?        S      0:20 named -u named
  557 ?        S      0:00 lpd
  616 ?        S      0:00 gpm -t ps/2
  630 ?        S      0:00 httpd
  709 ?        S      0:00 xfs -droppriv -daemon -port -1
  750 ?        S      0:06 /usr/sbin/sshd
  755 tty2     S      0:00 /sbin/mingetty tty2
  756 tty3     S      0:00 /sbin/mingetty tty3
  757 tty4     S      0:00 /sbin/mingetty tty4
  758 tty5     S      0:00 /sbin/mingetty tty5
  759 tty6     S      0:00 /sbin/mingetty tty6
 2611 tty1     S      0:00 /sbin/mingetty tty1
16526 ?        S      0:00 httpd
16528 ?        S      0:00 httpd
18678 ?        S      0:00 httpd
18679 ?        S      0:00 httpd
18680 ?        S      0:00 httpd
18681 ?        S      0:00 httpd
18682 ?        S      0:00 httpd
18683 ?        S      0:00 httpd
19308 ?        S      0:00 httpd
19309 ?        S      0:00 httpd
19310 ?        S      0:00 httpd
20757 ?        S      0:00 httpd
20936 ?        S      0:00 httpd
20937 ?        S      0:00 httpd
20938 ?        S      0:00 httpd
20939 ?        S      0:00 httpd
20940 ?        S      0:00 httpd
20941 ?        S      0:00 httpd
22244 ?        S      0:00 sendmail: accepting connections on port 25
22331 ?        S      0:00 in.telnetd: manos.timpanogas.org                     
22332 pts/1    S      0:00 login -- jmerkey                    
22333 pts/1    S      0:00 -bash
22359 pts/1    S      0:00 su -
22360 pts/1    S      0:00 -bash
22638 ?        S      0:00 ftpd: cvx-36.flex.com: anonymous/guest@unknown.net: R
22841 ?        S      0:00 ftpd: cadmium.sge.net: anonymous/bpftp@: IDLE        
22866 ?        S      0:00 perl /usr/libexec/webmin/miniserv.pl /etc/webmin/mini
22875 pts/1    R      0:00 ps -ax

--------------EF65FD30FD900E62CDD3651A
Content-Type: text/plain; charset=us-ascii;
 name="mailq.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mailq.txt"

		Mail Queue (11 requests)
--Q-ID-- --Size-- -Priority- ---Q-Time--- -----------Sender/Recipient-----------
FAA15716X   31418     200564 Nov  9 05:01 <linux-kernel-owner@vger.kernel.org>
          7BIT
					  <linux-archive@timpanogas.org>
					  <jmerkey@timpanogas.org>
FAA20318X   32693     201751 Nov 10 05:29 <linux-kernel-owner@vger.kernel.org>
          7BIT
					  <linux-archive@timpanogas.org>
					  <jmerkey@timpanogas.org>
SAA01998X   34484     203865 Nov  6 18:20 <linux-kernel-owner@vger.kernel.org>
          7BIT
					  <linux-archive@timpanogas.org>
					  <jmerkey@timpanogas.org>
QAA01341X   65091     204150 Nov  6 16:50 <linux-kernel-owner@vger.kernel.org>
          7BIT
					  <mharris@opensourceadvocate.org>
SAA13390X   41368     210478 Nov  8 18:03 <linux-kernel-owner@vger.kernel.org>
          7BIT
					  <linux-archive@timpanogas.org>
					  <jmerkey@timpanogas.org>
LAA03425X  158115     218595 Nov  6 11:27 <jmerkey@timpanogas.org>
					  <Mark.Coe@rrd.com>
					  <jmerkey@timpanogas.com>
QAA01343X   65091     234150 Nov  6 16:50 <linux-kernel-owner@vger.kernel.org>
          7BIT
					  <linux-archive@timpanogas.org>
					  <jmerkey@timpanogas.org>
KAA21225X  205041     235799 Nov 10 10:26 <paperboy@g2news.com>
      8BITMIME
					  <jmerkey@timpanogas.com>
FAA20229X    1457     272283+Nov 10 05:01 <mharris@opensourceadvocate.org>
                 (Warning: could not send message for past 1 hour)
					  <andre@linux-ide.org>
QAA06681X  242511     272929 Nov  7 16:18 <jmerkey@timpanogas.org>
      8BITMIME
					  <andre@timpanogas.org>
PAA12261X  576306     606701 Nov  8 15:06 <langus@timpanogas.com>
					  <jmerkey@timpanogas.com>

--------------EF65FD30FD900E62CDD3651A--


--------------6F053B7B32D5A229ABFC201C--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
