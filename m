Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965687AbWKDVDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965687AbWKDVDo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 16:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965689AbWKDVDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 16:03:44 -0500
Received: from mx1.mandriva.com ([212.85.150.183]:9194 "EHLO mx1.mandriva.com")
	by vger.kernel.org with ESMTP id S965687AbWKDVDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 16:03:43 -0500
Date: Sat, 4 Nov 2006 18:03:32 -0300
From: Arnaldo Carvalho de Melo <acme@mandriva.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lwn@lwn.net
Subject: Top 100 inline functions (make allyesconfig) was Re: [ANNOUNCE] pahole and other DWARF2 utilities
Message-ID: <20061104210330.GA6028@mandriva.com>
References: <20061030213318.GA5319@mandriva.com> <20061030203334.09caa368.akpm@osdl.org> <20061103190729.GB25363@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20061103190729.GB25363@mandriva.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2006 at 04:07:29PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Oct 30, 2006 at 08:33:34PM -0800, Andrew Morton wrote:
> > On Mon, 30 Oct 2006 18:33:19 -0300
> > Arnaldo Carvalho de Melo <acme@mandriva.com> wrote:
> > 
> > > 	Further ideas on how to use the DWARF2 information include tools
> > > that will show where inlines are being used, how much code is added by
> > > inline functions,
> > 
> > It would be quite useful to be able to identify inlined functions which are
> > good candidates for uninlining.
> 
> Top 50 inline functions expanded more than once by sum of its expansions
> in a vmlinux file built for qemu, most things are modules, columns are
> (inline function name, number of times it was expanded, sum in bytes of
> its expansions, number of source files where expansions ocurred):
> 
> [acme@newtoy guinea_pig-2.6]$ pfunct --total_inline_stats
> ../../acme/OUTPUT/qemu/net-2.6/vmlinux | grep -v ': 1 ' | sort -k3 -nr |
> head -50
> 
> get_current                        676   5732 155

Ok, this time for a 'make allyesconfig' build, top 100, for the list of
all 6021 inline functions that were expanded more than once in this 281
MB vmlinux image download the 93 KB files at:

http://oops.merseine.nu:81/acme/vmlinux.allyesconfig.inlines.txt.gz

totsz = Total size of all expansions for this inline function
nrexp = Number of times this function was expanded (inlined)
avgsz = Average expansion size
nrsrc = number of source files where this function was expanded

Some cases are bogus due to namespace colisions, I'll work on mangling
the function name with the file where it was defined, but most should
be ok.

- Arnaldo

        name                             totsz / nrexp = avgsz  nrsrc
        -------------------------------------------------------------
     1	outb                             65077    8180       7    505
     2	__fswab16                        58827    2313      25    459
     3	__memcpy                         54640    2241      24   1141
     4	writel                           49011    5989       8    364
     5	__constant_c_and_count_memset    42967    3163      13   1708
     6	skb_put                          41512     741      56    416
     7	kmalloc                          38684    2345      16   1366
     8	__constant_memcpy                35716    2536      14   1633
     9	get_current                      31233    4058       7    886
    10	cfi_build_cmd                    28439     131     217      7
    11	strcmp                           23324    1008      23    329
    12	kzalloc                          22413    1326      16   1014
    13	current_thread_info              21816    2815       7   1319
    14	readl                            21575    3953       5    363
    15	__constant_c_memset              21014     732      28    578
    16	strcpy                           20681    1420      14    611
    17	__fswab32                        19797    3566       5    442
    18	init_hw                          18441       7    2634     12
    19	strncmp                          18199     596      30    212
    20	writeb                           17825    2611       6    205
    21	INIT_LIST_HEAD                   15476    1713       9    746
    22	__OUTPLL                         15399     125     123      4
    23	inb                              15174    3246       4    499
    24	snd_echo_create                  15098       5    3019      5
    25	NCR5380_information_transfer     14699       6    2449      6
    26	__INPLL                          14541     117     124      4
    27	outw                             14475    1437      10    135
    28	up                               14467     796      18    189
    29	down                             13710     396      34    152
    30	do_write_buffer                  13674       3    4558      3
    31	pci_write_config_byte            13069     527      24    176
    32	outb_p                           12659    1241      10     97
    33	strlen                           12658     931      13    435
    34	load_firmware                    12616       7    1802     13
    35	pci_read_config_byte             12369     560      22    218
    36	cfi_send_gen_cmd                 11559      41     281      5
    37	module_put                       11462     265      43    203
    38	skb_push                         11297     259      43    182
    39	set_bit                          11160    1296       8    676
    40	readb                            11015    1728       6    219
    41	radeon_pll_errata_after_data     10855     127      85      4
    42	skb_pull                         10812     303      35    187
    43	outl                             10718    1151       9    128
    44	netif_wake_queue                 10355     348      29    173
    45	add_timer                         9896     390      25    252
    46	pci_free_consistent               9834     376      26    130
    47	clear_bit                         9654     962      10    600
    48	list_add_tail                     9570     712      13    434
    49	__fswab64                         9553     521      18     97
    50	ahd_outb                          9538     295      32      4
    51	hscx_int_main                     9526      12     793     12
    52	prefetch                          9467    1764       5    720
    53	pci_read_config_dword             9247     425      21    163
    54	pci_write_config_dword            9116     402      22    140
    55	dev_alloc_skb                     9072     221      41    209
    56	constant_test_bit                 8764    1955       4   1034
    57	dev_kfree_skb_irq                 8617      98      87    104
    58	writew                            8569    1148       7    128
    59	ahc_outb                          8426     261      32      6
    60	netif_stop_queue                  8364     495      16    187
    61	brelse                            8354     822      10    155
    62	skb_reserve                       8187     444      18    320
    63	ahc_inb                           8182     303      27      6
    64	pci_read_config_word              8174     359      22    178
    65	skb_trim                          8153     112      72    101
    66	i_size_read                       8071     181      44     67
    67	list_del_init                     7916     461      17    210
    68	pci_map_single                    7756     186      41    103
    69	jedec_reset                       7689       6    1281      1
    70	WriteHSCXCMDR                     7576      78      97     17
    71	frontend_init                     7352       7    1050      7
    72	le_key_k_type                     7302      60     121     12
    73	pci_write_config_word             7123     284      25    137
    74	dst_release                       7059     125      56     71
    75	ahd_set_modes                     6930      55     126      4
    76	strncpy                           6651     296      22    153
    77	usb_serial_debug_data             6380      61     104     25
    78	pci_alloc_consistent              6352     214      29    129
    79	atomic_inc                        6235    1022       6    683
    80	readw                             6170    1001       6    122
    81	block_til_ready                   6146      10     614     10
    82	load_dsp                          6141       5    1228     12
    83	test_and_set_bit                  6096     605      10    394
    84	try_module_get                    6065     176      34    151
    85	input_report_key                  5939     208      28     65
    86	load_module                       5933       2    2966      2
    87	usb_fill_bulk_urb                 5846     114      51     62
    88	skb_queue_head_init               5783     151      38    110
    89	ahd_inb                           5739     208      27      4
    90	device_init                       5689       2    2844      2
    91	sctp_add_cmd_sf                   5665     197      28      2
    92	pci_set_drvdata                   5595     496      11    268
    93	skb_tailroom                      5432     313      17    117
    94	port_detect                       5419       2    2709      2
    95	dequeue_rx                        5339       3    1779      3
    96	dev_to_shost                      5338     167      31     22
    97	skb_header_pointer                5289     120      44     53
    98	prism2_init_local_data            5226       3    1742      3
    99	sb_bread                          5216     164      31     87
   100	strchr                            5171     195      26    115
