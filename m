Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267602AbTAMIYd>; Mon, 13 Jan 2003 03:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267614AbTAMIYd>; Mon, 13 Jan 2003 03:24:33 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:65298 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267602AbTAMIY0>; Mon, 13 Jan 2003 03:24:26 -0500
Message-Id: <200301130821.h0D8Kis26772@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Jean Tourrilhes <jt@bougret.hpl.hp.com>, alan_mcreynolds@hpl.hp.com,
       jkaba@sarnoff.com, torgeir@trenger.ro
Subject: 2.4.20-pre11: PCI Wavelan card loses connection
Date: Mon, 13 Jan 2003 10:20:14 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I bought a PCI wireless card, a DLink-520 (I think, I forgot exactly
(it's at home), anyway, lspci dump is below).

We (my father and me) made a fairly long helical aerial.
We are trying to communicate over ~15 km with a small wireless cell.
(~10 hosts, one AP).

We can successfully associate with it, signal is weak as expected.
But after a short while our eth0 seems to 'fall off the net'
and while it looks like we can send packets, we see no incoming data
at all.

Since I have almost zero wireless experience, I'll be happy if someone
with said experience can read further and say what bites us.

Typical bcast ping:
===================
PING 10.206.173.127 (10.206.173.127): 56 octets data
64 octets from 10.206.173.111: icmp_seq=0 ttl=64 time=0.4 ms
64 octets from 10.206.173.4: icmp_seq=0 ttl=64 time=13.8 ms (DUP!)
64 octets from 10.206.173.6: icmp_seq=0 ttl=255 time=27.2 ms (DUP!)
64 octets from 10.206.173.5: icmp_seq=0 ttl=255 time=50.0 ms (DUP!)
64 octets from 10.206.173.111: icmp_seq=1 ttl=64 time=0.3 ms
64 octets from 10.206.173.4: icmp_seq=1 ttl=64 time=5.5 ms (DUP!)
64 octets from 10.206.173.6: icmp_seq=1 ttl=255 time=20.3 ms (DUP!)
64 octets from 10.206.173.5: icmp_seq=1 ttl=255 time=59.8 ms (DUP!)
64 octets from 10.206.173.3: icmp_seq=1 ttl=64 time=99.5 ms (DUP!)
64 octets from 10.206.173.111: icmp_seq=2 ttl=64 time=0.3 ms
64 octets from 10.206.173.111: icmp_seq=3 ttl=64 time=0.4 ms
64 octets from 10.206.173.111: icmp_seq=4 ttl=64 time=0.3 ms
64 octets from 10.206.173.111: icmp_seq=5 ttl=64 time=0.3 ms
64 octets from 10.206.173.111: icmp_seq=6 ttl=64 time=0.3 ms
64 octets from 10.206.173.111: icmp_seq=7 ttl=64 time=0.3 ms
64 octets from 10.206.173.111: icmp_seq=8 ttl=64 time=0.3 ms
64 octets from 10.206.173.111: icmp_seq=9 ttl=64 time=0.3 ms
64 octets from 10.206.173.111: icmp_seq=10 ttl=64 time=0.3 ms
64 octets from 10.206.173.111: icmp_seq=11 ttl=64 time=0.3 ms
64 octets from 10.206.173.111: icmp_seq=12 ttl=64 time=0.3 ms
64 octets from 10.206.173.111: icmp_seq=13 ttl=64 time=0.3 ms
64 octets from 10.206.173.111: icmp_seq=14 ttl=64 time=0.3 ms
64 octets from 10.206.173.4: icmp_seq=14 ttl=64 time=4.1 ms (DUP!)
64 octets from 10.206.173.6: icmp_seq=14 ttl=255 time=19.3 ms (DUP!)
64 octets from 10.206.173.3: icmp_seq=14 ttl=64 time=73.9 ms (DUP!)
64 octets from 10.206.173.5: icmp_seq=14 ttl=255 time=153.1 ms (DUP!)
64 octets from 10.206.173.111: icmp_seq=15 ttl=64 time=0.3 ms
64 octets from 10.206.173.4: icmp_seq=15 ttl=64 time=4.7 ms (DUP!)
64 octets from 10.206.173.6: icmp_seq=15 ttl=255 time=24.1 ms (DUP!)
64 octets from 10.206.173.3: icmp_seq=15 ttl=64 time=107.8 ms (DUP!)
64 octets from 10.206.173.5: icmp_seq=15 ttl=255 time=149.9 ms (DUP!)
64 octets from 10.206.173.111: icmp_seq=16 ttl=64 time=0.3 ms
64 octets from 10.206.173.4: icmp_seq=16 ttl=64 time=4.1 ms (DUP!)
64 octets from 10.206.173.6: icmp_seq=16 ttl=255 time=22.4 ms (DUP!)
64 octets from 10.206.173.3: icmp_seq=16 ttl=64 time=91.6 ms (DUP!)
64 octets from 10.206.173.5: icmp_seq=16 ttl=255 time=143.1 ms (DUP!)
64 octets from 10.206.173.111: icmp_seq=17 ttl=64 time=0.3 ms
64 octets from 10.206.173.111: icmp_seq=18 ttl=64 time=0.3 ms
64 octets from 10.206.173.111: icmp_seq=19 ttl=64 time=0.3 ms
64 octets from 10.206.173.111: icmp_seq=20 ttl=64 time=0.3 ms
64 octets from 10.206.173.111: icmp_seq=21 ttl=64 time=0.3 ms
....no more replies ever except .111 (i.e. us)....

As you see, replies come irregularly. Maybe it is due to big distance
and weak signal. But soon icmp replies stop coming at all, no matter
how long I ping. Either Tx or Rx does not really happen I think :(

I tried to reset (ifconfig down/up) the card every 10 mins
and pinging and tcpdumping overnight (automated ;).
It helps but not for long. The longest period of replies coming
is less than 2 minutes. Usually card 'falls off the net' much sooner
(~30 seconds).

Looking at syslog I think sometimes card timeouts at Tx and gets
reset by network code. Then the cycle repeats. It works for some
30 seconds on average, then go deaf.

Here are all kinds of more-or-less relevant information:

syslog at modprobe orinoco_pci
==============================
kernel: hermes.c: 5 Apr 2002 David Gibson <hermes@gibson.dropbear.id.au>
kernel: orinoco.c 0.11b (David Gibson <hermes@gibson.dropbear.id.au> and others)
kernel: PCI: Found IRQ 11 for device 00:0f.0
kernel: PCI: Sharing IRQ 11 with 00:07.5
kernel: Detected Orinoco/Prism2 PCI device at 00:0f.0,
    mem:0xD8000000 to 0xD8000FFF -> 0xd0c66000, irq:11
kernel: Reset done....................................
    ..................................................
    ..................................................
    ..................................................
    ..................................................
    ...........;
kernel: Clear Reset...................................
    ..................................................
    ..................................................
    ..................................................
    ..................................................
    ..................................................
    ..................................................
    ..................................................
    ..................................................
    ..................................................
    .................;
kernel: pci_cor : reg = 0x0 - DD5 - DA3
kernel: eth0: Station identity 001f:0006:0001:0003
kernel: eth0: Looks like an Intersil firmware version 1.03
kernel: eth0: Ad-hoc demo mode supported
kernel: eth0: IEEE standard IBSS ad-hoc mode supported
kernel: eth0: WEP supported, 104-bit key
kernel: eth0: MAC address 00:05:5D:FA:1A:DA
kernel: eth0: Station name "Prism  I"
kernel: eth0: ready

syslog while I play with ping and iwconfig
==========================================
kernel: eth0: Channel out of range (0)!
	*** LOTS of these. Is this normal?
kernel: eth0: Channel out of range (0)!
kernel: eth0: Error -110 writing Tx descriptor to BAP
	*** (110 == ETIMEDOUT) Why? Do I have to worry?
last message repeated 5 times
kernel: eth0: Channel out of range (0)!
kernel: eth0: Channel out of range (0)!
last message repeated 3 times
kernel: eth0: Channel out of range (0)!
kernel: eth0: Channel out of range (0)!
kernel: eth0: Channel out of range (0)!
kernel: eth0: Channel out of range (0)!
kernel: eth0: Error -110 writing Tx descriptor to BAP
last message repeated 6 times
kernel: eth0: Error -110 writing Tx descriptor to BAP
kernel: eth0: Error -110 writing Tx descriptor to BAP
kernel: eth0: Error -110 writing Tx descriptor to BAP
kernel: eth0: Channel out of range (0)!
kernel: eth0: Error -110 writing Tx descriptor to BAP
last message repeated 9 times
last message repeated 2 times
kernel: eth0: Channel out of range (0)!
kernel: eth0: Error -110 writing Tx descriptor to BAP
last message repeated 8 times
last message repeated 5 times
kernel: eth0: Error -110 writing Tx descriptor to BAP
kernel: eth0: Error -110 writing Tx descriptor to BAP
last message repeated 7 times
kernel: eth0: Channel out of range (0)!
last message repeated 16 times
last message repeated 30 times
last message repeated 30 times
kernel: eth0: Channel out of range (0)!
last message repeated 2 times
kernel: eth0: Channel out of range (0)!
last message repeated 15 times
	*** _TONS_ of 'eth0: Channel out of range (0)!' snipped ***
kernel: eth0: Channel out of range (0)!
last message repeated 8 times
kernel: eth0: Channel out of range (0)!
last message repeated 16 times
last message repeated 31 times
last message repeated 30 times
kernel: eth0: error -5 reading info frame. Frame dropped.
	*** (5 == EIO) This is probably a mangled packet. okay...
kernel: eth0: Channel out of range (0)!
kernel: eth0: Error -110 writing Tx descriptor to BAP
last message repeated 17 times
last message repeated 4 times
last message repeated 2 times
kernel: NETDEV WATCHDOG: eth0: transmit timed out
kernel: eth0: Tx timeout! Resetting card. ALLOCFID=ffff, TXCOMPLFID=ffff, EVSTAT=8000
	*** What do these numbers mean?
kernel: eth0: Channel out of range (0)!
last message repeated 2 times
-- MARK --
-- MARK --
kernel: eth0: Channel out of range (0)!
last message repeated 2 times
kernel: eth0: Error -110 writing Tx descriptor to BAP
last message repeated 13 times
last message repeated 6 times

ifconfig:
=========
eth0      Link encap:Ethernet  HWaddr 00:05:5D:FA:1A:DA
          inet addr:10.206.173.111  Bcast:10.206.173.127  Mask:255.255.255.128
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:789 errors:565 dropped:0 overruns:0 frame:436
          TX packets:1140 errors:2397 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:72416 (70.7 Kb)  TX bytes:640704 (625.6 Kb)
          Interrupt:11 Base address:0x6000 Memory:d8000000-d8000fff

iwconfig after reset (ifconfig eth0 down/up cycle):
===================================================
eth0      IEEE 802.11-DS  ESSID:"AirNet"  Nickname:"Prism  I"
          Mode:Managed  Frequency:2.462GHz  Access Point: 00:10:E7:F5:82:CC
          Bit Rate:2Mb/s   Tx-Power=15 dBm   Sensitivity:1/3
          Retry min limit:8   RTS thr:off   Fragment thr:off
          Encryption key:off
          Power Management:off
          Link Quality:10/92  Signal level:-89 dBm  Noise level:-134 dBm
                       ^^^^^               ^^^^^^^              ^^^^^^^^
          Rx invalid nwid:0  Rx invalid crypt:129  Rx invalid frag:0
          Tx excessive retries:6  Invalid misc:0   Missed beacon:0
	  
iwconfig when card 'falls off the net':
=======================================
eth0      IEEE 802.11-DS  ESSID:"AirNet"  Nickname:"Prism  I"
          Mode:Managed  Frequency:2.427GHz  Access Point: 00:10:E7:F5:82:CC
          Bit Rate:2Mb/s   Tx-Power=15 dBm   Sensitivity:1/3
          Retry min limit:8   RTS thr:off   Fragment thr:off
          Encryption key:off
          Power Management:off
          Link Quality:0/92  Signal level:107/153  Noise level:123/153
                       ^^^^               ^^^^^^^              ^^^^^^^
          Rx invalid nwid:0  Rx invalid crypt:122  Rx invalid frag:0
          Tx excessive retries:6  Invalid misc:0   Missed beacon:0

What makes me wonder: how come there is no signal *while I am pinging*?
AP *has to* retranslate it to the peers, we have to see it too!
Maybe there is *no* Tx happening on our side?

lspci -vvvxxx:
==============
00:0f.0 Network controller: Harris Semiconductor: Unknown device 3873 (rev 01)
	Subsystem: D-Link System Inc: Unknown device 3501
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 60 12 73 38 07 00 90 02 01 00 80 02 08 20 00 00
10: 08 00 00 d8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 11 01 35
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 00 00
40: 80 80 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 02 7e
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

lsmod
=====
Module                  Size  Used by    Not tainted
nls_iso8859-1           2880   0  (autoclean)
nls_cp437               4384   0  (autoclean)
af_packet              11336   0  (autoclean)
orinoco_pci             2560   1
orinoco                35072   0  [orinoco_pci]
hermes                  6624   0  [orinoco_pci orinoco]
nls_koi8-r              3872   0  (autoclean)
nls_cp866               3872   0  (autoclean)
nfsd                   66112   0  (unused)
autofs                 11172   1
via82cxxx_audio        19200   0
soundcore               4260   2  [via82cxxx_audio]
ac97_codec              9824   0  [via82cxxx_audio]
serial                 55712   0  (unused)
isa-pnp                29148   0  [serial]

uname -a
========
Linux localhost 2.4.20-pre11 #5 SMP Sat Nov 2 11:53:37 GMT+2 2002 i686 unknown

Not really SMP, it's a SMP kernel on UP box.


Here are parts of driver code responsible for syslog messages,
for your easy reference:

drivers/net/wireless/orinoco.c
==============================
static long orinoco_hw_get_freq(struct orinoco_private *priv)
{

        hermes_t *hw = &priv->hw;
        int err = 0;
        u16 channel;
        long freq = 0;

        orinoco_lock(priv);

        err = hermes_read_wordrec(hw, USER_BAP, HERMES_RID_CURRENTCHANNEL, &channel);
        if (err)
                goto out;

        if ( (channel < 1) || (channel > NUM_CHANNELS) ) {
                struct net_device *dev = priv->ndev;

                printk(KERN_WARNING "%s: Channel out of range (%d)!\n", dev->name, channel);
                err = -EBUSY;
                goto out;

        }
        freq = channel_frequency[channel-1] * 100000;

 out:
        orinoco_unlock(priv);

        if (err > 0)
                err = -EBUSY;
        return err ? err : freq;
}
...................
static int
orinoco_xmit(struct sk_buff *skb, struct net_device *dev)
{
        struct orinoco_private *priv = (struct orinoco_private *)dev->priv;
        struct net_device_stats *stats = &priv->stats;
        hermes_t *hw = &priv->hw;
        int err = 0;

	....sanity checks here, we met them....

        orinoco_lock(priv);

        /* Length of the packet body */
        /* FIXME: what if the skb is smaller than this? */
        len = max_t(int,skb->len - ETH_HLEN, ETH_ZLEN);

        eh = (struct ethhdr *)skb->data;

        memset(&desc, 0, sizeof(desc));
        desc.tx_control = cpu_to_le16(HERMES_TXCTRL_TX_OK | HERMES_TXCTRL_TX_EX);
        err = hermes_bap_pwrite(hw, USER_BAP, &desc, sizeof(desc), txfid, 0);
        if (err) {
                printk(KERN_ERR "%s: Error %d writing Tx descriptor to BAP\n",
                       dev->name, err);
                stats->tx_errors++;
                goto fail;
        }
....................
static void
orinoco_tx_timeout(struct net_device *dev)
{
        struct orinoco_private *priv = (struct orinoco_private *)dev->priv;
        struct net_device_stats *stats = &priv->stats;
        struct hermes *hw = &priv->hw;
        int err = 0;

        printk(KERN_WARNING "%s: Tx timeout! Resetting card. ALLOCFID=%04x,
	    TXCOMPLFID=%04x, EVSTAT=%04x\n", dev->name,
	    hermes_read_regn(hw, ALLOCFID), hermes_read_regn(hw, TXCOMPLFID),
	    hermes_read_regn(hw, EVSTAT));

        stats->tx_errors++;
....................
--
vda
