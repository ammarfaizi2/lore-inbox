Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWBSFS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWBSFS5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 00:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbWBSFS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 00:18:57 -0500
Received: from nessie.weebeastie.net ([220.233.7.36]:17930 "EHLO
	bunyip.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S1750905AbWBSFS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 00:18:56 -0500
Date: Sun, 19 Feb 2006 16:19:15 +1100
From: CaT <cat@zip.com.au>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.15: usb storage device not detected
Message-ID: <20060219051915.GA1888@zip.com.au>
References: <20060109130540.GB2035@zip.com.au> <20060109101713.469d3a7f.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109101713.469d3a7f.zaitcev@redhat.com>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for the excessive delay. I had to put in the work around and
evetually the whole thing fell out of my head. :/

On Mon, Jan 09, 2006 at 10:17:13AM -0800, Pete Zaitcev wrote:
> On Tue, 10 Jan 2006 00:05:50 +1100, CaT <cat@zip.com.au> wrote:
> > kernel: [  111.330762] usb 1-5: new high speed USB device using ehci_hcd and address 3
> > kernel: [  112.180267] ub(1.3): Stall at GetMaxLUN, using 1 LUN
> > kernel: [  151.843141] usb 1-5: USB disconnect, address 3
> 
> This is very unusual. The quickest workaround is to unset CONFIG_BLK_DEV_UB,

That does work.

> like Alan said. But it is very curious how this could happen. Care to
> collect a usbmon trace for me? There's a howto in
> Documentation/usb/usbmon.txt

Is this what you require? I turned on all the (relevant) debug options I
could find in the kernel so as to get as much info as possible (that's
hopefully useful :): So anyway, here's dmesg:

[  478.728305] hub 1-0:1.0: state 5 ports 6 chg 0000 evt 0020
[  478.728325] ehci_hcd 0000:00:10.3: GetStatus port 5 status 001803 POWER sig=j CSC CONNECT
[  478.728338] hub 1-0:1.0: port 5, status 0501, change 0001, 480 Mb/s
[  478.832191] hub 1-0:1.0: debounce: port 5: total 100ms stable 100ms status 0x501
[  478.883403] ehci_hcd 0000:00:10.3: port 5 high speed
[  478.883410] ehci_hcd 0000:00:10.3: GetStatus port 5 status 001005 POWER sig=se0 PE CONNECT
[  478.934114] usb 1-5: new high speed USB device using ehci_hcd and address 3
[  478.934260] ehci_hcd 0000:00:10.3: devpath 5 ep0in 3strikes
[  478.934509] ehci_hcd 0000:00:10.3: devpath 5 ep0in 3strikes
[  478.934759] ehci_hcd 0000:00:10.3: devpath 5 ep0in 3strikes
[  478.985358] ehci_hcd 0000:00:10.3: GetStatus port 5 status 001002 POWER sig=se0 CSC
[  478.985384] hub 1-0:1.0: state 5 ports 6 chg 0000 evt 0020
[  479.227903] hub 1-0:1.0: state 5 ports 6 chg 0000 evt 0020
[  479.227922] ehci_hcd 0000:00:10.3: GetStatus port 5 status 001803 POWER sig=j CSC CONNECT
[  479.227935] hub 1-0:1.0: port 5, status 0501, change 0001, 480 Mb/s
[  479.331802] hub 1-0:1.0: debounce: port 5: total 100ms stable 100ms status 0x501
[  479.383049] ehci_hcd 0000:00:10.3: GetStatus port 5 status 001002 POWER sig=se0 CSC
[  479.727515] hub 1-0:1.0: state 5 ports 6 chg 0000 evt 0020
[  479.727535] ehci_hcd 0000:00:10.3: GetStatus port 5 status 001803 POWER sig=j CSC CONNECT
[  479.727548] hub 1-0:1.0: port 5, status 0501, change 0001, 480 Mb/s
[  479.831411] hub 1-0:1.0: debounce: port 5: total 100ms stable 100ms status 0x501
[  479.882565] ehci_hcd 0000:00:10.3: port 5 high speed
[  479.882572] ehci_hcd 0000:00:10.3: GetStatus port 5 status 001005 POWER sig=se0 PE CONNECT
[  479.933336] usb 1-5: new high speed USB device using ehci_hcd and address 5
[  479.984518] ehci_hcd 0000:00:10.3: port 5 high speed
[  479.984525] ehci_hcd 0000:00:10.3: GetStatus port 5 status 001005 POWER sig=se0 PE CONNECT
[  480.048249] usb 1-5: default language 0x0409
[  480.048503] usb 1-5: new device strings: Mfr=0, Product=1, SerialNumber=0
[  480.048508] usb 1-5: Product: USB TO IDE
[  480.048582] usb 1-5: hotplug
[  480.049005] usb 1-5: adding 1-5:1.0 (config #1, interface 0)
[  480.049017] usb 1-5:1.0: hotplug
[  480.049060] ub 1-5:1.0: usb_probe_interface
[  480.049063] ub 1-5:1.0: usb_probe_interface - got id
[  480.544901] ub(1.5): Stall at GetMaxLUN, using 1 LUN
[  485.541339] drivers/usb/core/inode.c: creating file '005'
[  501.960162] hub 1-0:1.0: state 5 ports 6 chg 0000 evt 0020
[  501.960183] ehci_hcd 0000:00:10.3: GetStatus port 5 status 001002 POWER sig=se0 CSC
[  501.960196] hub 1-0:1.0: port 5, status 0100, change 0001, 12 Mb/s
[  501.960201] usb 1-5: USB disconnect, address 5
[  501.960253] usb 1-5: usb_disable_device nuking all URBs
[  501.960264] usb 1-5: unregistering interface 1-5:1.0
[  501.960455] usb 1-5:1.0: hotplug
[  501.960557] usb 1-5: unregistering device
[  501.960587] usb 1-5: hotplug
[  502.064051] hub 1-0:1.0: debounce: port 5: total 100ms stable 100ms status 0x100

And here's /sys/kernel/debug/usbmon/1t during plugin and unplug:

c13c97c0 743239930 C Ii:001:01 0 1 = 20
c13c97c0 743239949 S Ii:001:01 -115 2 = 2000
cc0056e0 743239975 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cc0056e0 743239987 C Ci:001:00 0 4 = 01050100
cc0056e0 743239991 S Co:001:00 s 23 01 0010 0005 0000 0
cc0056e0 743239993 C Co:001:00 0 0
cc0056e0 743240001 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cc0056e0 743240002 C Ci:001:00 0 4 = 01050000
cec8f9a0 743265924 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cec8f9a0 743265930 C Ci:001:00 0 4 = 01050000
cec8f9a0 743291917 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cec8f9a0 743291920 C Ci:001:00 0 4 = 01050000
cec8f9a0 743317912 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cec8f9a0 743317915 C Ci:001:00 0 4 = 01050000
cec8f9a0 743343907 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cec8f9a0 743343910 C Ci:001:00 0 4 = 01050000
cec8f9a0 743343927 S Co:001:00 s 23 03 0004 0005 0000 0
cec8f9a0 743343930 C Co:001:00 0 0
cec8f9a0 743394902 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cec8f9a0 743395171 C Ci:001:00 0 4 = 03051000
cec8f9a0 743445894 S Co:001:00 s 23 01 0014 0005 0000 0
cec8f9a0 743445897 C Co:001:00 0 0
cec8f9a0 743445949 S Ci:000:00 s 80 06 0100 0000 0040 64 <
cec8f9a0 743446054 C Ci:000:00 -71 0
cec8f9a0 743446063 S Ci:000:00 s 80 06 0100 0000 0040 64 <
cec8f9a0 743446303 C Ci:000:00 -71 0
cec8f9a0 743446311 S Ci:000:00 s 80 06 0100 0000 0040 64 <
cec8f9a0 743446552 C Ci:000:00 -71 0
cec8f9a0 743446561 S Co:001:00 s 23 03 0004 0005 0000 0
cec8f9a0 743446563 C Co:001:00 0 0
c13c97c0 743489889 C Ii:001:01 0 1 = 20
c13c97c0 743489892 S Ii:001:01 -115 2 = 2000
cec8f9a0 743496885 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cec8f9a0 743497183 C Ci:001:00 0 4 = 00011100
cec8f9a0 743497185 S Co:001:00 s 23 01 0014 0005 0000 0
cec8f9a0 743497187 C Co:001:00 0 0
cec8f9a0 743497189 S Co:001:00 s 23 01 0001 0005 0000 0
cec8f9a0 743497191 C Co:001:00 0 0
cec8f9a0 743497197 S Co:001:00 s 23 01 0001 0005 0000 0
cec8f9a0 743497199 C Co:001:00 0 0
cec8f9a0 743497208 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cec8f9a0 743497209 C Ci:001:00 0 4 = 00010000
c13c97c0 743739854 C Ii:001:01 0 1 = 20
c13c97c0 743739861 S Ii:001:01 -115 2 = 2000
cec8f9a0 743739885 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cec8f9a0 743739899 C Ci:001:00 0 4 = 01050100
cec8f9a0 743739902 S Co:001:00 s 23 01 0010 0005 0000 0
cec8f9a0 743739904 C Co:001:00 0 0
cec8f9a0 743739911 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cec8f9a0 743739913 C Ci:001:00 0 4 = 01050000
cec8f9a0 743765845 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cec8f9a0 743765849 C Ci:001:00 0 4 = 01050000
cec8f9a0 743791840 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cec8f9a0 743791843 C Ci:001:00 0 4 = 01050000
cec8f9a0 743817837 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cec8f9a0 743817839 C Ci:001:00 0 4 = 01050000
cec8f9a0 743843832 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cec8f9a0 743843835 C Ci:001:00 0 4 = 01050000
cec8f9a0 743843852 S Co:001:00 s 23 03 0004 0005 0000 0
cec8f9a0 743843854 C Co:001:00 0 0
cec8f9a0 743894826 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cec8f9a0 743895130 C Ci:001:00 0 4 = 00011000
cec8f9a0 743895133 S Co:001:00 s 23 01 0014 0005 0000 0
cec8f9a0 743895134 C Co:001:00 0 0
cec8f9a0 743895137 S Co:001:00 s 23 01 0001 0005 0000 0
cec8f9a0 743895138 C Co:001:00 0 0
cec8f9a0 743895143 S Co:001:00 s 23 01 0001 0005 0000 0
cec8f9a0 743895145 C Co:001:00 0 0
c13c97c0 744239779 C Ii:001:01 0 1 = 20
c13c97c0 744239787 S Ii:001:01 -115 2 = 2000
cec8f9a0 744239812 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cec8f9a0 744239825 C Ci:001:00 0 4 = 01050100
cec8f9a0 744239829 S Co:001:00 s 23 01 0010 0005 0000 0
cec8f9a0 744239831 C Co:001:00 0 0
cec8f9a0 744239839 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cec8f9a0 744239840 C Ci:001:00 0 4 = 01050000
cec8f9a0 744265769 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cec8f9a0 744265772 C Ci:001:00 0 4 = 01050000
cec8f9a0 744291764 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cec8f9a0 744291767 C Ci:001:00 0 4 = 01050000
cec8f9a0 744317757 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cec8f9a0 744317760 C Ci:001:00 0 4 = 01050000
cec8f9a0 744343757 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cec8f9a0 744343759 C Ci:001:00 0 4 = 01050000
cec8f9a0 744343774 S Co:001:00 s 23 03 0004 0005 0000 0
cec8f9a0 744343776 C Co:001:00 0 0
cec8f9a0 744394746 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cec8f9a0 744394961 C Ci:001:00 0 4 = 03051000
cec8f9a0 744445743 S Co:001:00 s 23 01 0014 0005 0000 0
cec8f9a0 744445747 C Co:001:00 0 0
cec8f9a0 744445830 S Ci:000:00 s 80 06 0100 0000 0040 64 <
cec8f9a0 744446093 C Ci:000:00 0 18 = 12010002 00000040 e3050307 29000001 0001
cec8f9a0 744446104 S Co:001:00 s 23 03 0004 0005 0000 0
cec8f9a0 744446106 C Co:001:00 0 0
cec8f9a0 744496729 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cec8f9a0 744496977 C Ci:001:00 0 4 = 03051000
cec8f9a0 744547726 S Co:001:00 s 23 01 0014 0005 0000 0
cec8f9a0 744547729 C Co:001:00 0 0
cec8f9a0 744547732 S Co:000:00 s 00 05 0005 0000 0000 0
cec8f9a0 744547980 C Co:000:00 0 0
cec8f9a0 744559725 S Ci:005:00 s 80 06 0100 0000 0012 18 <
cec8f9a0 744559982 C Ci:005:00 0 18 = 12010002 00000040 e3050307 29000001 0001
cec8f9a0 744559991 S Ci:005:00 s 80 06 0200 0000 0009 9 <
cec8f9a0 744560232 C Ci:005:00 0 9 = 09022000 01010080 fa
cec8f9a0 744560239 S Ci:005:00 s 80 06 0200 0000 0020 32 <
cec8f9a0 744560481 C Ci:005:00 0 32 = 09022000 01010080 fa090400 00020806 50000705 81020002 00070502 02000200
cec8fa20 744560496 S Ci:005:00 s 80 06 0300 0000 00ff 255 <
cec8fa20 744560730 C Ci:005:00 0 4 = 04030904
cec8fa20 744560741 S Ci:005:00 s 80 06 0301 0409 00ff 255 <
cec8fa20 744560981 C Ci:005:00 0 22 = 16035500 53004200 20005400 4f002000 49004400 4500
cec8fa20 744561203 S Co:005:00 s 00 09 0001 0000 0000 0
cec8fa20 744561481 C Co:005:00 0 0
c31f414c 744561726 S Bo:005:02 -115 31 = 55534243 00000000 00000000 00000600 00000000 00000000 00000000 000000
c31f414c 744561854 C Bo:005:02 0 31 >
c31f414c 744561863 S Bi:005:01 -115 13 <
c31f414c 745057444 C Bi:005:01 0 13 = 55534253 00000000 00000000 00
c31f414c 745057463 S Ci:005:00 s a1 fe 0000 0000 0001 1 <
c31f414c 745057691 C Ci:005:00 -32 0
c31f414c 745057750 S Co:005:00 s 02 01 0000 0081 0000 0
c31f414c 745058065 C Co:005:00 0 0
c31f414c 745058072 S Co:005:00 s 02 01 0000 0002 0000 0
c31f414c 745058314 C Co:005:00 0 0
c31f414c 745058386 S Bo:005:02 -115 31 = 55534243 01000000 00000000 00000600 00000000 00000000 00000000 000000
c31f414c 745058437 C Bo:005:02 0 31 >
c31f414c 745058444 S Bi:005:01 -115 13 <
c31f414c 750057024 C Bi:005:01 -104 0
c13c97c0 766486396 C Ii:001:01 0 1 = 20
c13c97c0 766486413 S Ii:001:01 -115 2 = 2000
cc005ce0 766486439 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cc005ce0 766486452 C Ci:001:00 0 4 = 00010100
cc005ce0 766486456 S Co:001:00 s 23 01 0010 0005 0000 0
cc005ce0 766486458 C Co:001:00 0 0
cec8f9a0 766486884 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cec8f9a0 766486887 C Ci:001:00 0 4 = 00010000
cc0054e0 766512388 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cc0054e0 766512392 C Ci:001:00 0 4 = 00010000
cc0054e0 766538383 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cc0054e0 766538386 C Ci:001:00 0 4 = 00010000
cc0054e0 766564379 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cc0054e0 766564382 C Ci:001:00 0 4 = 00010000
cc0054e0 766590375 S Ci:001:00 s a3 00 0000 0005 0004 4 <
cc0054e0 766590377 C Ci:001:00 0 4 = 00010000

Hope this helps. If not, shout and umm... I shouldn't be this long next
time. Sorry. :/

-- 
    "To the extent that we overreact, we proffer the terrorists the
    greatest tribute."
    	- High Court Judge Michael Kirby
