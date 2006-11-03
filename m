Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753471AbWKCTHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471AbWKCTHn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 14:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753470AbWKCTHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 14:07:43 -0500
Received: from mx1.mandriva.com ([212.85.150.183]:15795 "EHLO mx1.mandriva.com")
	by vger.kernel.org with ESMTP id S1753471AbWKCTHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 14:07:42 -0500
Date: Fri, 3 Nov 2006 16:07:30 -0300
From: Arnaldo Carvalho de Melo <acme@mandriva.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lwn@lwn.net
Subject: Re: [ANNOUNCE] pahole and other DWARF2 utilities
Message-ID: <20061103190729.GB25363@mandriva.com>
References: <20061030213318.GA5319@mandriva.com> <20061030203334.09caa368.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20061030203334.09caa368.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 08:33:34PM -0800, Andrew Morton wrote:
> On Mon, 30 Oct 2006 18:33:19 -0300
> Arnaldo Carvalho de Melo <acme@mandriva.com> wrote:
> 
> > 	Further ideas on how to use the DWARF2 information include tools
> > that will show where inlines are being used, how much code is added by
> > inline functions,
> 
> It would be quite useful to be able to identify inlined functions which are
> good candidates for uninlining.

Top 50 inline functions expanded more than once by sum of its expansions
in a vmlinux file built for qemu, most things are modules, columns are
(inline function name, number of times it was expanded, sum in bytes of
its expansions, number of source files where expansions ocurred):

[acme@newtoy guinea_pig-2.6]$ pfunct --total_inline_stats
../../acme/OUTPUT/qemu/net-2.6/vmlinux | grep -v ': 1 ' | sort -k3 -nr |
head -50

get_current                        676   5732 155
xfrm_selector_match                  6   4778   2
__memcpy                           177   4326  89
kmalloc                            185   3991 119
__constant_c_memset                113   3556  69
__constant_c_and_count_memset      225   3161 156
prefetch                           333   2915 101
__ext3_journal_dirty_metadata       44   2810   6
skb_put                             34   2650  27
module_put                          80   2613  42
strcmp                             108   2506  49
__ext3_journal_get_write_access     41   2482   6
down                                57   2253  19
__fswab16                           96   2172  33
dst_release                         34   2130  23
list_add_tail                       88   2030  67
kzalloc                             89   2007  76
__constant_memcpy                  146   1930 118
tcp_done                             8   1918   4
brelse                             128   1897  16
__nlmsg_put                         21   1856  13
INIT_LIST_HEAD                     226   1848  88
pci_read_config_byte                54   1802   9
list_del_init                      103   1782  39
ip_rt_put                           27   1692  12
pci_read_config_word                50   1675  11
strlen                             108   1671  64
__xfrm6_selector_match               3   1615   2
__skb_trim                          25   1604  21
do_follow_link                       2   1543   1
strncmp                             48   1533  22
__xfrm4_selector_match               6   1525   2
outb_p                             136   1518   9
tcp_set_state                       14   1501   5
find_group_orlov                     2   1456   2
inet_twsk_put                       16   1448   5
pci_write_config_byte               38   1433  10
up                                  68   1372  19
pci_read_config_dword               42   1357  12
raw_local_irq_restore              366   1292  88
skb_tailroom                        62   1239  23
set_bit                            155   1232  68
put_task_struct                     53   1227  11
print_irq_desc                       2   1206   1
skb_trim                            14   1192  13
__do_follow_link                     2   1190   1
nf_hook_thresh                      16   1164   8
dget                                47   1147  19
__raw_local_irq_save               314   1145  85
__fswab32                          130   1117  28

- Arnaldo
