Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283704AbRK3Qr6>; Fri, 30 Nov 2001 11:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283706AbRK3Qrs>; Fri, 30 Nov 2001 11:47:48 -0500
Received: from smtp.monmouth.com ([209.191.58.6]:15891 "EHLO smtp.monmouth.com")
	by vger.kernel.org with ESMTP id <S283702AbRK3Qra>;
	Fri, 30 Nov 2001 11:47:30 -0500
Message-ID: <3C07A9F3.457F81B7@monmouth.com>
Date: Fri, 30 Nov 2001 10:46:59 -0500
From: Dipak <dipak@monmouth.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-6.1smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rajasekhar Inguva <irajasek@in.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Routing table problems
In-Reply-To: <OF8DFA00F6.3DAC22D2-ON65256B31.003CB38A@in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    Add the following line in the /etc/rc.d/init.d/network script at the end
of "start" case:
    /sbin/route add default gw <whatever is your default getway ip address>

    OR
    You can modify the /etc/sysconfig/network-scripts/ifcfg-eth* to add a
line as
    GW=<whatever is your default getway ip address>
    and modify the /etc/rc.d/init.d/network script if statement at the end of
"start" case. For example, here are few lines of what I've done in my script:

        # Add non interface-specific static-routes.
        if [ -f /etc/sysconfig/static-routes ]; then
           grep "^any" /etc/sysconfig/static-routes | while read ignore type
dest netmask mask gw gateway; do
              [ "${gateway}" != "${gateway##[0-9}" ] && \
                /sbin/route add -$type $dest $netmask $mask $gw $gateway
           done
        fi

        touch /var/lock/subsys/network
        ;;

best of luck!
dipak

Rajasekhar Inguva wrote:

> Hi All,
>
> I am facing a problem ( ???, maybe it works that way, but i really dont
> know ) with regards to routing table behavior when using ifconfig on a
> network interface.
>
> 1) netstat -nr      Shows my default gateway for network 0.0.0.0
>
> 2) ifconfig eth0 down
>
> 3) netstat -nr      No entry for the default gateway is shown (
> understandable )
>
> 4) ifconfig eth0 up
>
> After the the 4'th command, my interface is up and has it's IP address set
> correctly. But .....
>
> netstat -nr  does not show my default gateway for network 0.0.0.0 !!.
> Pinging any IP outside of my subnet, results in "Network is unreachable"
> error.
>
> Is is meant to be that way ? or is there a problem here ?
>
> I've tried it on kernel versions, 2.4.0, 2.4.5 & 2.4.15
>
> FYI : This has been tried using both DHCP and Static IP.
>
> Thanks in advance !
>
> Regards,
>
> Raj
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

