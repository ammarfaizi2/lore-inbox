Return-Path: <linux-kernel-owner+w=401wt.eu-S932944AbXABHak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932944AbXABHak (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 02:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932945AbXABHak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 02:30:40 -0500
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:49748 "EHLO
	liaag1ac.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932944AbXABHaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 02:30:39 -0500
Date: Tue, 2 Jan 2007 02:25:19 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [BUG] panic 2.6.20-rc3 in nf_conntrack
To: "MalteSch@gmx.de" <MalteSch@gmx.de>
Cc: linux-kernel@vger.kernel.org, Patrick McHardy <kaber@trash.net>
Message-ID: <200701020228_MC3-1-D707-115D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200701011753.11826.MalteSch@gmx.de>

On Mon, 1 Jan 2007 17:53:04 +0100, MalteSch@gmx.de wrote:

> I tried 2.6.20-rc3 with the new nf_nat stuff on my gateway machine with pppoe 
> (ADSL) access to the internet. When I shut down my ppp0 interface the kernel 
> panics.

> [  336.467373] BUG: unable to handle kernel NULL pointer dereference at virtual address 0000001c
> [  336.467513]  printing eip:
> [  336.467566] dff1605f
> [  336.467624] *pde = 00000000
> [  336.467687] Oops: 0000 [#1]
> [ 336.467740] Modules linked in: netconsole rpcsec_gss_krb5 auth_rpcgss
> nfs xfrm_user xfrm4_tunnel tunnel4 ipcomp esp4 ah4 nfsd exportfs lockd
> nfs_acl sunrpc autofs4 button ac battery capi capifs nf_conntrack_ipv6
> ip6table_filter ip6_tables xt_mark sch_sfq act_police cls_u32
> sch_ingress sch_htb ipt_ECN ipt_MASQUERADE ipt_ULOG ipt_LOG xt_state
> ipt_TCPMSS xt_tcpudp xt_pkttype iptable_raw xt_CLASSIFY xt_CONNMARK
> xt_MARK ipt_REJECT xt_length ipt_ipp2p xt_connmark ipt_owner ipt_recent
> ipt_iprange xt_physdev xt_policy xt_multiport xt_conntrack
> iptable_mangle iptable_nat nf_nat nf_conntrack_ipv4 nf_conntrack
> nfnetlink sit iptable_filter ip_tables x_tables af_packet ipv6 deflate
> twofish twofish_common serpent blowfish des cbc aes xcbc sha256 md5
> crypto_null hmac crypto_hash af_key ext3 jbd mbcache dm_snapshot
> dm_mirror dm_mod lp sha1 arc4 ecb blkcipher cryptomgr crypto_algapi
> ppp_mppe ppp_deflate zlib_deflate capidrv isdn tun pppoe pppox
> ppp_generic slhc tcp_cubic snd_ac97_codec ac97_bus snd_pcm_oss
> snd_mixer_oss s! nd_pcm snd_timer snd_page_alloc snd parport_pc parport
> soundcore b1pci b1dma b1 kernelcapi floppy pcspkr reiserfs via_rhine
> ehci_hcd ide_disk uhci_hcd usbcore sata_via libata scsi_mod 3c59x mii
> thermal processor fan unix via82cxxx ide_core [ 336.476053] CPU: 0
> [  336.476055] EIP:    0060:[<dff1605f>]    Not tainted VLI
> [  336.476057] EFLAGS: 00010206   (2.6.20-rc3 #0)
> [  336.476284] EIP is at device_cmp+0x1b/0x2e [ipt_MASQUERADE]
> [  336.476344] eax: de6d4000   ebx: 00000000   ecx: d944b7a0   edx: dd664d48
> [  336.476404] esi: 00000004   edi: 00001f58   ebp: 000003eb   esp: de6d4e90
> [  336.476464] ds: 007b   es: 007b   ss: 0068
> [  336.476520] Process pppd (pid: 3846, ti=de6d4000 task=deda4a90 task.ti=de6d4000)
> [  336.476580] Stack: dd664c7c dd664c84 dfe8990d 00000004 dff16044 00000000 dff16b18 c164b000 
> [  336.477024]        00000002 dff16041 c011c79f c164b000 000010d0 00001091 00000000 c01ea41a 
> [  336.477527]        c164b000 c01e99d5 d98b49e0 00000000 d98b4a0c ddc100c0 c022200b c164b000 
> [  336.478030] Call Trace:
> [  336.478132]  [<dfe8990d>] nf_ct_iterate_cleanup+0x62/0xda [nf_conntrack]
> [  336.478259]  [<dff16044>] device_cmp+0x0/0x2e [ipt_MASQUERADE]
> [  336.478366]  [<dff16041>] masq_device_event+0x12/0x15 [ipt_MASQUERADE]
> [  336.478468]  [<c011c79f>] notifier_call_chain+0x19/0x29
> [  336.478576]  [<c01ea41a>] dev_close+0x5c/0x60
> [  336.478678]  [<c01e99d5>] dev_change_flags+0x47/0xe4
> [  336.478845]  [<c022200b>] devinet_ioctl+0x251/0x56e
> [  336.478946]  [<c01eaa6e>] dev_ifsioc+0x113/0x3e1
> [  336.479046]  [<c018c505>] copy_to_user+0x2d/0x44
> [  336.479176]  [<c01e12ec>] sock_ioctl+0x18e/0x1ad
> [  336.479281]  [<c01e115e>] sock_ioctl+0x0/0x1ad
> [  336.479381]  [<c0151011>] do_ioctl+0x19/0x4d
> [  336.479482]  [<c010f0ee>] do_page_fault+0x277/0x511
> [  336.479589]  [<c0151244>] vfs_ioctl+0x1ff/0x216
> [  336.479758]  [<c015128e>] sys_ioctl+0x33/0x4d

AFAICT 'nat' is zero here because bit 2 of i->features is zero:

static inline int
device_cmp(struct ip_conntrack *i, void *ifindex)
{
#ifdef CONFIG_NF_NAT_NEEDED
        struct nf_conn_nat *nat = nfct_nat(i);
#endif
        int ret;

        read_lock_bh(&masq_lock);
#ifdef CONFIG_NF_NAT_NEEDED
        ret = (nat->masq_index == (int)(long)ifindex);  <===============
#else
        ret = (i->nat.masq_index == (int)(long)ifindex);
#endif
        read_unlock_bh(&masq_lock);

        return ret;
}

-- 
MBTI: IXTP

