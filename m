Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbVL1T5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbVL1T5P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 14:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbVL1T5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 14:57:14 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:19856 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964894AbVL1T5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 14:57:14 -0500
Subject: Re: 2.6.14-rt22 (and mainline): netstat -anop triggers excessive
	latencies
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0512281423250.14148@gandalf.stny.rr.com>
References: <1135145065.29182.10.camel@mindpipe>
	 <1135204629.14810.43.camel@localhost.localdomain>
	 <1135732888.22744.51.camel@mindpipe>
	 <Pine.LNX.4.58.0512272110490.10936@gandalf.stny.rr.com>
	 <1135736563.22744.58.camel@mindpipe>
	 <Pine.LNX.4.58.0512272128040.12225@gandalf.stny.rr.com>
	 <1135791206.6183.2.camel@mindpipe>
	 <Pine.LNX.4.58.0512281415070.14021@gandalf.stny.rr.com>
	 <Pine.LNX.4.58.0512281423250.14148@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Wed, 28 Dec 2005 14:58:39 -0500
Message-Id: <1135799919.6602.13.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-28 at 14:24 -0500, Steven Rostedt wrote:
> 
> On Wed, 28 Dec 2005, Steven Rostedt wrote:
> 
> >
> > On Wed, 28 Dec 2005, Lee Revell wrote:
> >
> > > On Tue, 2005-12-27 at 21:30 -0500, Steven Rostedt wrote:
> > > > OK, I did find it though, and it only had one rej. So you probably can
> > > > easily do that change yourself.
> > > >
> > > > Aw heck, here it is anyway. (look everybody, a patch pulled in with
> > > > pine!).  Complements of quilt.
> > >
> > > Nope, does not help.  We still do way too much work in softirq context.
> > >
> >
> > Are you still doing the 'netstat -anop'?  And what does it look like. On
> > my test machine the max latency I get is 83 usecs.
> >
> 
> Oh, try out 2.6.15-rc7-rt1, it has the patch as well.  That's what I was
> testing.

OK, I'll try that.  Meanwhile here's the output:

Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    Timer
tcp        0      0 0.0.0.0:111             0.0.0.0:*               LISTEN     3733/portmap        off (0.00/0/0)
tcp        0      0 127.0.0.1:53            0.0.0.0:*               LISTEN     4119/pdnsd          off (0.00/0/0)
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN     4175/sshd           off (0.00/0/0)
tcp        0      0 0.0.0.0:3128            0.0.0.0:*               LISTEN     4226/(squid)        off (0.00/0/0)
tcp        0      0 0.0.0.0:988             0.0.0.0:*               LISTEN     4198/rpc.statd      off (0.00/0/0)
tcp        0      0 127.0.0.1:3128          127.0.0.1:46440         ESTABLISHED4226/(squid)        off (0.00/0/0)
tcp        0    679 192.168.0.186:52783     216.239.37.99:80        ESTABLISHED4226/(squid)        on (1.44/0/0)
tcp        0      0 127.0.0.1:3128          127.0.0.1:46441         ESTABLISHED4226/(squid)        off (0.00/0/0)
tcp        0      0 127.0.0.1:3128          127.0.0.1:46442         ESTABLISHED4226/(squid)        off (0.00/0/0)
tcp        0      0 127.0.0.1:3128          127.0.0.1:46436         ESTABLISHED4226/(squid)        off (0.00/0/0)
tcp        0      0 192.168.0.186:45773     216.239.37.147:80       ESTABLISHED4226/(squid)        off (0.00/0/0)
tcp        0      0 127.0.0.1:46435         127.0.0.1:3128          ESTABLISHED7090/epiphany       off (0.00/0/0)
tcp        0      0 127.0.0.1:46436         127.0.0.1:3128          ESTABLISHED7090/epiphany       off (0.00/0/0)
tcp        0      0 127.0.0.1:46441         127.0.0.1:3128          ESTABLISHED7090/epiphany       off (0.00/0/0)
tcp        0      0 127.0.0.1:46440         127.0.0.1:3128          ESTABLISHED7090/epiphany       off (0.00/0/0)
tcp        0      0 127.0.0.1:46442         127.0.0.1:3128          ESTABLISHED7090/epiphany       off (0.00/0/0)
tcp        0    689 192.168.0.186:44819     216.239.37.104:80       ESTABLISHED4226/(squid)        on (81.35/4/0)
tcp        0      0 127.0.0.1:3128          127.0.0.1:46435         ESTABLISHED4226/(squid)        off (0.00/0/0)
tcp        0      0 192.168.0.186:52674     216.239.37.147:80       ESTABLISHED4226/(squid)        off (0.00/0/0)
tcp        0      0 192.168.0.186:40319     204.179.240.224:80      ESTABLISHED4226/(squid)        off (0.00/0/0)
tcp        0      0 192.168.0.186:37416     207.245.101.66:110      ESTABLISHED6602/evolution-2.4  off (0.00/0/0)
udp        0      0 0.0.0.0:32770           0.0.0.0:*                          4226/(squid)        off (0.00/0/0)
udp        0      0 127.0.0.1:53            0.0.0.0:*                          4119/pdnsd          off (0.00/0/0)
udp        0      0 0.0.0.0:3130            0.0.0.0:*                          4226/(squid)        off (0.00/0/0)
udp        0      0 0.0.0.0:68              0.0.0.0:*                          3714/dhclient       off (0.00/0/0)
udp        0      0 0.0.0.0:982             0.0.0.0:*                          4198/rpc.statd      off (0.00/0/0)
udp        0      0 0.0.0.0:985             0.0.0.0:*                          4198/rpc.statd      off (0.00/0/0)
udp        0      0 0.0.0.0:111             0.0.0.0:*                          3733/portmap        off (0.00/0/0)
udp        0      0 192.168.0.186:123       0.0.0.0:*                          4213/ntpd           off (0.00/0/0)
udp        0      0 127.0.0.1:123           0.0.0.0:*                          4213/ntpd           off (0.00/0/0)
udp        0      0 0.0.0.0:123             0.0.0.0:*                          4213/ntpd           off (0.00/0/0)
raw        0      0 0.0.0.0:1               0.0.0.0:*               7          4119/pdnsd          off (0.00/0/0)
Active UNIX domain sockets (servers and established)
Proto RefCnt Flags       Type       State         I-Node PID/Program name    Path
unix  2      [ ACC ]     STREAM     LISTENING     8199     4405/gnome-panel    /tmp/orbit-rlrevell/linc-1135-0-75aee2989367b
unix  2      [ ACC ]     STREAM     LISTENING     7798     4362/dbus-daemon    @/tmp/dbus-kRDDuSrN1q
unix  2      [ ACC ]     STREAM     LISTENING     7438     4186/xfs            /tmp/.font-unix/fs7100
unix  2      [ ACC ]     STREAM     LISTENING     22817    6624/evolution-alar /tmp/orbit-rlrevell/linc-19e0-0-418a226b84ab1
unix  2      [ ACC ]     STREAM     LISTENING     8232     4410/nautilus       /tmp/orbit-rlrevell/linc-113a-0-20dcab1dc9146
unix  2      [ ACC ]     STREAM     LISTENING     22837    6627/evolution-data /tmp/orbit-rlrevell/linc-19e3-0-418a226bed67c
unix  2      [ ACC ]     STREAM     LISTENING     6824     4032/hald           @/tmp/hald-local/dbus-UBJ3XWbS5r
unix  2      [ ACC ]     STREAM     LISTENING     6716     3961/X              /tmp/.X11-unix/X0
unix  2      [ ACC ]     STREAM     LISTENING     8263     4426/wnck-applet    /tmp/orbit-rlrevell/linc-114a-0-126d407ed6dcb
unix  2      [ ACC ]     STREAM     LISTENING     6804     4017/dbus-daemon    /var/run/dbus/system_bus_socket
unix  2      [ ACC ]     STREAM     LISTENING     8278     4429/gnome-vfs-daem /tmp/orbit-rlrevell/linc-114d-0-5fd29980f3c38
unix  2      [ ACC ]     STREAM     LISTENING     7356     4119/pdnsd          /var/cache/pdnsd/pdnsd.status
unix  2      [ ACC ]     STREAM     LISTENING     6499     3914/gdm            /tmp/.gdm_socket
unix  2      [ ACC ]     STREAM     LISTENING     8038     4296/x-session-mana /tmp/.ICE-unix/4296
unix  2      [ ACC ]     STREAM     LISTENING     7790     4357/ssh-agent      /tmp/ssh-xSlHgN4296/agent.4296
unix  2      [ ACC ]     STREAM     LISTENING     8047     4372/gnome-keyring- /tmp/keyring-CUdodH/socket
unix  2      [ ACC ]     STREAM     LISTENING     7793     4358/ssh-agent      /tmp/ssh-TlyMwW4296/agent.4296
unix  2      [ ACC ]     STREAM     LISTENING     8563     4449/clock-applet   /tmp/orbit-rlrevell/linc-1161-0-5fbb14bfadfe1
unix  5      [ ]         DGRAM                    12665    5224/syslogd        /dev/log
unix  2      [ ACC ]     STREAM     LISTENING     8059     4374/bonobo-activat /tmp/orbit-rlrevell/linc-1116-0-3300a4bb6a4e4
unix  2      [ ACC ]     STREAM     LISTENING     8325     4435/mapping-daemon /tmp/mapping-rlrevell
unix  2      [ ACC ]     STREAM     LISTENING     7817     4364/gconfd-2       /tmp/orbit-rlrevell/linc-110c-0-2626af2ccf5c
unix  2      [ ACC ]     STREAM     LISTENING     8081     4376/metacity       /tmp/orbit-rlrevell/linc-1118-0-5420b519e2d9
unix  2      [ ACC ]     STREAM     LISTENING     7827     4296/x-session-mana /tmp/orbit-rlrevell/linc-10c8-0-1f3d77523943b
unix  2      [ ACC ]     STREAM     LISTENING     8096     4378/gnome-settings /tmp/orbit-rlrevell/linc-111a-0-4c7b8685621
unix  2      [ ]         DGRAM                    3191     1704/udevd          @udevd
unix  2      [ ACC ]     STREAM     LISTENING     8107     4381/gam_server     @/tmp/fam-rlrevell-
unix  2      [ ]         DGRAM                    6825     4032/hald           @/var/run/hal/hotplug_socket2
unix  2      [ ACC ]     STREAM     LISTENING     22718    6602/evolution-2.4  /tmp/orbit-rlrevell/linc-19ca-0-b33d517def1
unix  2      [ ACC ]     STREAM     LISTENING     24819    7090/epiphany       /tmp/orbit-rlrevell/linc-1bb2-0-2751674193866
unix  2      [ ]         DGRAM                    25181    7118/su             
unix  3      [ ]         STREAM     CONNECTED     24826    7090/epiphany       /tmp/orbit-rlrevell/linc-1bb2-0-2751674193866
unix  3      [ ]         STREAM     CONNECTED     24825    4374/bonobo-activat 
unix  3      [ ]         STREAM     CONNECTED     24824    4374/bonobo-activat /tmp/orbit-rlrevell/linc-1116-0-3300a4bb6a4e4
unix  3      [ ]         STREAM     CONNECTED     24823    7090/epiphany       
unix  3      [ ]         STREAM     CONNECTED     24822    7090/epiphany       /tmp/orbit-rlrevell/linc-1bb2-0-2751674193866
unix  3      [ ]         STREAM     CONNECTED     24821    4364/gconfd-2       
unix  3      [ ]         STREAM     CONNECTED     24818    4364/gconfd-2       /tmp/orbit-rlrevell/linc-110c-0-2626af2ccf5c
unix  3      [ ]         STREAM     CONNECTED     24817    7090/epiphany       
unix  3      [ ]         STREAM     CONNECTED     24816    4296/x-session-mana /tmp/.ICE-unix/4296
unix  3      [ ]         STREAM     CONNECTED     24815    7090/epiphany       
unix  3      [ ]         STREAM     CONNECTED     24811    3961/X              /tmp/.X11-unix/X0
unix  3      [ ]         STREAM     CONNECTED     24810    7090/epiphany       
unix  3      [ ]         STREAM     CONNECTED     23157    6627/evolution-data /tmp/orbit-rlrevell/linc-19e3-0-418a226bed67c
unix  3      [ ]         STREAM     CONNECTED     23156    6602/evolution-2.4  
unix  3      [ ]         STREAM     CONNECTED     23153    6602/evolution-2.4  /tmp/orbit-rlrevell/linc-19ca-0-b33d517def1
unix  3      [ ]         STREAM     CONNECTED     23150    6627/evolution-data 
unix  3      [ ]         STREAM     CONNECTED     22855    6624/evolution-alar /tmp/orbit-rlrevell/linc-19e0-0-418a226b84ab1
unix  3      [ ]         STREAM     CONNECTED     22854    6627/evolution-data 
unix  3      [ ]         STREAM     CONNECTED     22853    6627/evolution-data /tmp/orbit-rlrevell/linc-19e3-0-418a226bed67c
unix  3      [ ]         STREAM     CONNECTED     22852    6624/evolution-alar 
unix  3      [ ]         STREAM     CONNECTED     22851    6627/evolution-data /tmp/orbit-rlrevell/linc-19e3-0-418a226bed67c
unix  3      [ ]         STREAM     CONNECTED     22849    4374/bonobo-activat 
unix  3      [ ]         STREAM     CONNECTED     22848    4374/bonobo-activat /tmp/orbit-rlrevell/linc-1116-0-3300a4bb6a4e4
unix  3      [ ]         STREAM     CONNECTED     22847    6627/evolution-data 
unix  3      [ ]         STREAM     CONNECTED     22840    6627/evolution-data /tmp/orbit-rlrevell/linc-19e3-0-418a226bed67c
unix  3      [ ]         STREAM     CONNECTED     22839    4364/gconfd-2       
unix  3      [ ]         STREAM     CONNECTED     22836    4364/gconfd-2       /tmp/orbit-rlrevell/linc-110c-0-2626af2ccf5c
unix  3      [ ]         STREAM     CONNECTED     22835    6627/evolution-data 
unix  3      [ ]         STREAM     CONNECTED     22824    6624/evolution-alar /tmp/orbit-rlrevell/linc-19e0-0-418a226b84ab1
unix  3      [ ]         STREAM     CONNECTED     22823    4374/bonobo-activat 
unix  3      [ ]         STREAM     CONNECTED     22822    4374/bonobo-activat /tmp/orbit-rlrevell/linc-1116-0-3300a4bb6a4e4
unix  3      [ ]         STREAM     CONNECTED     22821    6624/evolution-alar 
unix  3      [ ]         STREAM     CONNECTED     22820    6624/evolution-alar /tmp/orbit-rlrevell/linc-19e0-0-418a226b84ab1
unix  3      [ ]         STREAM     CONNECTED     22819    4364/gconfd-2       
unix  3      [ ]         STREAM     CONNECTED     22816    4364/gconfd-2       /tmp/orbit-rlrevell/linc-110c-0-2626af2ccf5c
unix  3      [ ]         STREAM     CONNECTED     22815    6624/evolution-alar 
unix  3      [ ]         STREAM     CONNECTED     22814    4296/x-session-mana /tmp/.ICE-unix/4296
unix  3      [ ]         STREAM     CONNECTED     22813    6624/evolution-alar 
unix  3      [ ]         STREAM     CONNECTED     22809    3961/X              /tmp/.X11-unix/X0
unix  3      [ ]         STREAM     CONNECTED     22808    6624/evolution-alar 
unix  3      [ ]         STREAM     CONNECTED     22725    6602/evolution-2.4  /tmp/orbit-rlrevell/linc-19ca-0-b33d517def1
unix  3      [ ]         STREAM     CONNECTED     22724    4374/bonobo-activat 
unix  3      [ ]         STREAM     CONNECTED     22723    4374/bonobo-activat /tmp/orbit-rlrevell/linc-1116-0-3300a4bb6a4e4
unix  3      [ ]         STREAM     CONNECTED     22722    6602/evolution-2.4  
unix  3      [ ]         STREAM     CONNECTED     22721    6602/evolution-2.4  /tmp/orbit-rlrevell/linc-19ca-0-b33d517def1
unix  3      [ ]         STREAM     CONNECTED     22720    4364/gconfd-2       
unix  3      [ ]         STREAM     CONNECTED     22717    4364/gconfd-2       /tmp/orbit-rlrevell/linc-110c-0-2626af2ccf5c
unix  3      [ ]         STREAM     CONNECTED     22716    6602/evolution-2.4  
unix  3      [ ]         STREAM     CONNECTED     22715    4296/x-session-mana /tmp/.ICE-unix/4296
unix  3      [ ]         STREAM     CONNECTED     22714    6602/evolution-2.4  
unix  3      [ ]         STREAM     CONNECTED     22710    3961/X              /tmp/.X11-unix/X0
unix  3      [ ]         STREAM     CONNECTED     22709    6602/evolution-2.4  
unix  2      [ ]         DGRAM                    18248    4003/klogd          
unix  2      [ ]         DGRAM                    12726    3714/dhclient       
unix  3      [ ]         STREAM     CONNECTED     9737     4296/x-session-mana /tmp/.ICE-unix/4296
unix  3      [ ]         STREAM     CONNECTED     9736     4562/xterm          
unix  3      [ ]         STREAM     CONNECTED     9735     3961/X              /tmp/.X11-unix/X0
unix  3      [ ]         STREAM     CONNECTED     9734     4562/xterm          
unix  3      [ ]         STREAM     CONNECTED     8582     4405/gnome-panel    /tmp/orbit-rlrevell/linc-1135-0-75aee2989367b
unix  3      [ ]         STREAM     CONNECTED     8581     4449/clock-applet   
unix  3      [ ]         STREAM     CONNECTED     8580     4449/clock-applet   /tmp/orbit-rlrevell/linc-1161-0-5fbb14bfadfe1
unix  3      [ ]         STREAM     CONNECTED     8579     4405/gnome-panel    
unix  3      [ ]         STREAM     CONNECTED     8576     4296/x-session-mana /tmp/.ICE-unix/4296
unix  3      [ ]         STREAM     CONNECTED     8575     4447/xterm          
unix  3      [ ]         STREAM     CONNECTED     8570     4449/clock-applet   /tmp/orbit-rlrevell/linc-1161-0-5fbb14bfadfe1
unix  3      [ ]         STREAM     CONNECTED     8569     4374/bonobo-activat 
unix  3      [ ]         STREAM     CONNECTED     8568     4374/bonobo-activat /tmp/orbit-rlrevell/linc-1116-0-3300a4bb6a4e4
unix  3      [ ]         STREAM     CONNECTED     8567     4449/clock-applet   
unix  3      [ ]         STREAM     CONNECTED     8566     4449/clock-applet   /tmp/orbit-rlrevell/linc-1161-0-5fbb14bfadfe1
unix  3      [ ]         STREAM     CONNECTED     8565     4364/gconfd-2       
unix  3      [ ]         STREAM     CONNECTED     8562     4364/gconfd-2       /tmp/orbit-rlrevell/linc-110c-0-2626af2ccf5c
unix  3      [ ]         STREAM     CONNECTED     8561     4449/clock-applet   
unix  3      [ ]         STREAM     CONNECTED     8557     3961/X              /tmp/.X11-unix/X0
unix  3      [ ]         STREAM     CONNECTED     8556     4447/xterm          
unix  3      [ ]         STREAM     CONNECTED     8550     3961/X              /tmp/.X11-unix/X0
unix  3      [ ]         STREAM     CONNECTED     8549     4449/clock-applet   
unix  3      [ ]         STREAM     CONNECTED     8331     4381/gam_server     @/tmp/fam-rlrevell-
unix  3      [ ]         STREAM     CONNECTED     8330     4405/gnome-panel    
unix  3      [ ]         STREAM     CONNECTED     8329     4435/mapping-daemon /tmp/mapping-rlrevell
unix  3      [ ]         STREAM     CONNECTED     8321     4410/nautilus       
unix  3      [ ]         STREAM     CONNECTED     8320     4405/gnome-panel    /tmp/orbit-rlrevell/linc-1135-0-75aee2989367b
unix  3      [ ]         STREAM     CONNECTED     8319     4429/gnome-vfs-daem 
unix  3      [ ]         STREAM     CONNECTED     8318     4429/gnome-vfs-daem /tmp/orbit-rlrevell/linc-114d-0-5fd29980f3c38
unix  3      [ ]         STREAM     CONNECTED     8317     4405/gnome-panel    
unix  3      [ ]         STREAM     CONNECTED     8312     4381/gam_server     @/tmp/fam-rlrevell-
unix  3      [ ]         STREAM     CONNECTED     8311     4405/gnome-panel    
unix  3      [ ]         STREAM     CONNECTED     8309     4405/gnome-panel    /tmp/orbit-rlrevell/linc-1135-0-75aee2989367b
unix  3      [ ]         STREAM     CONNECTED     8308     4426/wnck-applet    
unix  3      [ ]         STREAM     CONNECTED     8307     4426/wnck-applet    /tmp/orbit-rlrevell/linc-114a-0-126d407ed6dcb
unix  3      [ ]         STREAM     CONNECTED     8306     4405/gnome-panel    
unix  3      [ ]         STREAM     CONNECTED     8299     4410/nautilus       /tmp/orbit-rlrevell/linc-113a-0-20dcab1dc9146
unix  3      [ ]         STREAM     CONNECTED     8298     4429/gnome-vfs-daem 
unix  3      [ ]         STREAM     CONNECTED     8297     4429/gnome-vfs-daem /tmp/orbit-rlrevell/linc-114d-0-5fd29980f3c38
unix  3      [ ]         STREAM     CONNECTED     8296     4410/nautilus       
unix  3      [ ]         STREAM     CONNECTED     8293     4429/gnome-vfs-daem /tmp/orbit-rlrevell/linc-114d-0-5fd29980f3c38
unix  3      [ ]         STREAM     CONNECTED     8292     4374/bonobo-activat 
unix  3      [ ]         STREAM     CONNECTED     8291     4374/bonobo-activat /tmp/orbit-rlrevell/linc-1116-0-3300a4bb6a4e4
unix  3      [ ]         STREAM     CONNECTED     8290     4429/gnome-vfs-daem 
unix  3      [ ]         STREAM     CONNECTED     8285     4381/gam_server     @/tmp/fam-rlrevell-
unix  3      [ ]         STREAM     CONNECTED     8284     4429/gnome-vfs-daem 
unix  3      [ ]         STREAM     CONNECTED     8283     4017/dbus-daemon    /var/run/dbus/system_bus_socket
unix  3      [ ]         STREAM     CONNECTED     8282     4429/gnome-vfs-daem 
unix  3      [ ]         STREAM     CONNECTED     8281     4429/gnome-vfs-daem /tmp/orbit-rlrevell/linc-114d-0-5fd29980f3c38
unix  3      [ ]         STREAM     CONNECTED     8280     4364/gconfd-2       
unix  3      [ ]         STREAM     CONNECTED     8277     4364/gconfd-2       /tmp/orbit-rlrevell/linc-110c-0-2626af2ccf5c
unix  3      [ ]         STREAM     CONNECTED     8276     4429/gnome-vfs-daem 
unix  3      [ ]         STREAM     CONNECTED     8275     4426/wnck-applet    /tmp/orbit-rlrevell/linc-114a-0-126d407ed6dcb
unix  3      [ ]         STREAM     CONNECTED     8274     4374/bonobo-activat 
unix  3      [ ]         STREAM     CONNECTED     8273     4374/bonobo-activat /tmp/orbit-rlrevell/linc-1116-0-3300a4bb6a4e4
unix  3      [ ]         STREAM     CONNECTED     8272     4426/wnck-applet    
unix  3      [ ]         STREAM     CONNECTED     8268     4426/wnck-applet    /tmp/orbit-rlrevell/linc-114a-0-126d407ed6dcb
unix  3      [ ]         STREAM     CONNECTED     8265     4364/gconfd-2       
unix  3      [ ]         STREAM     CONNECTED     8262     4364/gconfd-2       /tmp/orbit-rlrevell/linc-110c-0-2626af2ccf5c
unix  3      [ ]         STREAM     CONNECTED     8261     4426/wnck-applet    
unix  3      [ ]         STREAM     CONNECTED     8257     3961/X              /tmp/.X11-unix/X0
unix  3      [ ]         STREAM     CONNECTED     8256     4426/wnck-applet    
unix  3      [ ]         STREAM     CONNECTED     8250     4410/nautilus       /tmp/orbit-rlrevell/linc-113a-0-20dcab1dc9146
unix  3      [ ]         STREAM     CONNECTED     8249     4374/bonobo-activat 
unix  3      [ ]         STREAM     CONNECTED     8248     4374/bonobo-activat /tmp/orbit-rlrevell/linc-1116-0-3300a4bb6a4e4
unix  3      [ ]         STREAM     CONNECTED     8247     4410/nautilus       
unix  3      [ ]         STREAM     CONNECTED     8242     4381/gam_server     @/tmp/fam-rlrevell-
unix  3      [ ]         STREAM     CONNECTED     8241     4410/nautilus       
unix  3      [ ]         STREAM     CONNECTED     8235     4410/nautilus       /tmp/orbit-rlrevell/linc-113a-0-20dcab1dc9146
unix  3      [ ]         STREAM     CONNECTED     8234     4364/gconfd-2       
unix  3      [ ]         STREAM     CONNECTED     8231     4364/gconfd-2       /tmp/orbit-rlrevell/linc-110c-0-2626af2ccf5c
unix  3      [ ]         STREAM     CONNECTED     8228     4410/nautilus       
unix  3      [ ]         STREAM     CONNECTED     8227     4296/x-session-mana /tmp/.ICE-unix/4296
unix  3      [ ]         STREAM     CONNECTED     8226     4410/nautilus       
unix  3      [ ]         STREAM     CONNECTED     8221     3961/X              /tmp/.X11-unix/X0
unix  3      [ ]         STREAM     CONNECTED     8220     4410/nautilus       
unix  3      [ ]         STREAM     CONNECTED     8206     4405/gnome-panel    /tmp/orbit-rlrevell/linc-1135-0-75aee2989367b
unix  3      [ ]         STREAM     CONNECTED     8205     4374/bonobo-activat 
unix  3      [ ]         STREAM     CONNECTED     8204     4374/bonobo-activat /tmp/orbit-rlrevell/linc-1116-0-3300a4bb6a4e4
unix  3      [ ]         STREAM     CONNECTED     8203     4405/gnome-panel    
unix  3      [ ]         STREAM     CONNECTED     8202     4405/gnome-panel    /tmp/orbit-rlrevell/linc-1135-0-75aee2989367b
unix  3      [ ]         STREAM     CONNECTED     8201     4364/gconfd-2       
unix  3      [ ]         STREAM     CONNECTED     8198     4364/gconfd-2       /tmp/orbit-rlrevell/linc-110c-0-2626af2ccf5c
unix  3      [ ]         STREAM     CONNECTED     8197     4405/gnome-panel    
unix  3      [ ]         STREAM     CONNECTED     8196     4296/x-session-mana /tmp/.ICE-unix/4296
unix  3      [ ]         STREAM     CONNECTED     8195     4405/gnome-panel    
unix  3      [ ]         STREAM     CONNECTED     8191     3961/X              /tmp/.X11-unix/X0
unix  3      [ ]         STREAM     CONNECTED     8190     4405/gnome-panel    
unix  3      [ ]         STREAM     CONNECTED     8170     4378/gnome-settings /tmp/orbit-rlrevell/linc-111a-0-4c7b8685621
unix  3      [ ]         STREAM     CONNECTED     8160     4296/x-session-mana 
unix  3      [ ]         STREAM     CONNECTED     8151     4378/gnome-settings /tmp/orbit-rlrevell/linc-111a-0-4c7b8685621
unix  3      [ ]         STREAM     CONNECTED     8150     4374/bonobo-activat 
unix  3      [ ]         STREAM     CONNECTED     8149     4374/bonobo-activat /tmp/orbit-rlrevell/linc-1116-0-3300a4bb6a4e4
unix  3      [ ]         STREAM     CONNECTED     8148     4378/gnome-settings 
unix  3      [ ]         STREAM     CONNECTED     8141     3961/X              /tmp/.X11-unix/X0
unix  3      [ ]         STREAM     CONNECTED     8140     4393/xscreensaver   
unix  3      [ ]         STREAM     CONNECTED     8109     4381/gam_server     @/tmp/fam-rlrevell-
unix  3      [ ]         STREAM     CONNECTED     8108     4378/gnome-settings 
unix  3      [ ]         STREAM     CONNECTED     8159     4296/x-session-mana /tmp/.ICE-unix/4296
unix  3      [ ]         STREAM     CONNECTED     8100     4376/metacity       
unix  3      [ ]         STREAM     CONNECTED     8099     4378/gnome-settings /tmp/orbit-rlrevell/linc-111a-0-4c7b8685621
unix  3      [ ]         STREAM     CONNECTED     8098     4364/gconfd-2       
unix  3      [ ]         STREAM     CONNECTED     8095     4364/gconfd-2       /tmp/orbit-rlrevell/linc-110c-0-2626af2ccf5c
unix  3      [ ]         STREAM     CONNECTED     8094     4378/gnome-settings 
unix  3      [ ]         STREAM     CONNECTED     8091     3961/X              /tmp/.X11-unix/X0
unix  3      [ ]         STREAM     CONNECTED     8090     4376/metacity       
unix  3      [ ]         STREAM     CONNECTED     8088     3961/X              /tmp/.X11-unix/X0
unix  3      [ ]         STREAM     CONNECTED     8087     4378/gnome-settings 
unix  3      [ ]         STREAM     CONNECTED     8084     4376/metacity       /tmp/orbit-rlrevell/linc-1118-0-5420b519e2d9
unix  3      [ ]         STREAM     CONNECTED     8083     4364/gconfd-2       
unix  3      [ ]         STREAM     CONNECTED     8080     4364/gconfd-2       /tmp/orbit-rlrevell/linc-110c-0-2626af2ccf5c
unix  3      [ ]         STREAM     CONNECTED     8079     4376/metacity       
unix  3      [ ]         STREAM     CONNECTED     8065     4296/x-session-mana /tmp/orbit-rlrevell/linc-10c8-0-1f3d77523943b
unix  3      [ ]         STREAM     CONNECTED     8064     4374/bonobo-activat 
unix  3      [ ]         STREAM     CONNECTED     8063     4374/bonobo-activat /tmp/orbit-rlrevell/linc-1116-0-3300a4bb6a4e4
unix  3      [ ]         STREAM     CONNECTED     8062     4296/x-session-mana 
unix  2      [ ]         DGRAM                    8025     4370/ntpd           
unix  3      [ ]         STREAM     CONNECTED     8017     4296/x-session-mana /tmp/orbit-rlrevell/linc-10c8-0-1f3d77523943b
unix  3      [ ]         STREAM     CONNECTED     8016     4364/gconfd-2       
unix  3      [ ]         STREAM     CONNECTED     8015     4364/gconfd-2       /tmp/orbit-rlrevell/linc-110c-0-2626af2ccf5c
unix  3      [ ]         STREAM     CONNECTED     7826     4296/x-session-mana 
unix  2      [ ]         DGRAM                    7812     4364/gconfd-2       
unix  3      [ ]         STREAM     CONNECTED     7806     3961/X              /tmp/.X11-unix/X0
unix  3      [ ]         STREAM     CONNECTED     7805     4296/x-session-mana 
unix  3      [ ]         STREAM     CONNECTED     7802     4362/dbus-daemon    
unix  3      [ ]         STREAM     CONNECTED     7801     4362/dbus-daemon    
unix  3      [ ]         STREAM     CONNECTED     7800     3961/X              /tmp/.X11-unix/X0
unix  3      [ ]         STREAM     CONNECTED     7799     4361/dbus-launch    
unix  2      [ ]         DGRAM                    7526     4226/(squid)        
unix  2      [ ]         DGRAM                    7523     4224/squid          
unix  2      [ ]         DGRAM                    7492     4213/ntpd           
unix  2      [ ]         DGRAM                    7462     4198/rpc.statd      
unix  3      [ ]         STREAM     CONNECTED     7240     4017/dbus-daemon    /var/run/dbus/system_bus_socket
unix  3      [ ]         STREAM     CONNECTED     7239     4032/hald           
unix  3      [ ]         STREAM     CONNECTED     6808     4017/dbus-daemon    
unix  3      [ ]         STREAM     CONNECTED     6807     4017/dbus-daemon    
unix  8      [ ]         STREAM     CONNECTED     7314     3961/X              /tmp/.X11-unix/X0
unix  3      [ ]         STREAM     CONNECTED     6730     3917/gdm            


