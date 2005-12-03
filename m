Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbVLCSah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbVLCSah (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 13:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbVLCSah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 13:30:37 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:41359 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S932115AbVLCSag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 13:30:36 -0500
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Mike Krufky <mkrufky@linuxtv.org>
Subject: Re: saa7134 broken in 2.6.15-rc2
Date: Sat, 3 Dec 2005 19:30:32 +0100
User-Agent: KMail/1.9
Cc: "Marco d'Itri" <md@linux.it>, linux-kernel@vger.kernel.org,
       video4linux-list@redhat.com, mchehab@brturbo.com.br
References: <20051128135254.GA4218@wonderland.linux.it> <20051128141003.GA4806@wonderland.linux.it> <438B1F89.7000402@linuxtv.org>
In-Reply-To: <438B1F89.7000402@linuxtv.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512031930.33166.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 November 2005 16:17, Mike Krufky wrote:
> Marco d'Itri wrote:
> 
> >On Nov 28, Duncan Sands <duncan.sands@math.u-psud.fr> wrote:
> >
> >>here seems to be something rotten in v4l land; here's one I got with 2.6.15-rc1-git1
> >>    
> >>
> >Yes, I should have STFW better: http://lkml.org/lkml/fancy/2005/11/24/194 .
> >
> >video-buf is still broken for me in -rc2, I can make xawtv work if I set
> >capture to "overlay", but it still complain about no input sources other
> >than "default".
> >
> Please try again, using the current -git snapshot.... The memory 
> problems have been fixed by Hugh Dickins in 2.6.15-rc2-git3 , and Dmitry 
> has submitted some input fixes after that.....
> 
> I am running 2.6.15-rc2-git6 with no problems.
> 
> If you are still having problems, please let us know, being sure to cc 
> the v4l mailing list.
> 
> Cheers,
> 
> Michael Krufky

OK, I've found the cause of this oops (which occurs with 2.6-git of today):

[4294787.157000] Unable to handle kernel paging request at virtual address d0337000
[4294787.181000]  printing eip:
[4294787.191000] e0b4e8a8
[4294787.199000] *pde = 00040067
[4294787.208000] *pte = 10337000
[4294787.218000] Oops: 0002 [#1]
[4294787.218000] DEBUG_PAGEALLOC
[4294787.218000] Modules linked in: usblp radeon drm tun video thermal processor fan button md5 ipv6 ipt_TOS ipt_MASQUERADE ipt_REJECT ipt_LOG ipt_state ipt_pkttype ipt
_owner ipt_recent ipt_iprange ipt_multiport ipt_conntrack iptable_mangle ip_nat_irc ip_nat_tftp ip_nat_ftp iptable_nat ip_nat ip_conntrack_irc ip_conntrack_tftp ip_conntr
ack_ftp ip_conntrack iptable_filter ip_tables generic i2c_viapro cdc_ether usbnet uhci_hcd usbcore snd_bt87x tuner tvaudio bttv video_buf firmware_class i2c_algo_bit v4l2
_common btcx_risc tveeprom i2c_core videodev snd_cs46xx snd_rawmidi snd_seq_device snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore s
nd_page_alloc via_agp agpgart nls_cp437 ntfs mousedev psmouse unix
[4294787.218000] CPU:    0
[4294787.218000] EIP:    0060:[<e0b4e8a8>]    Not tainted VLI
[4294787.218000] EFLAGS: 00210202   (2.6.15-rc4-gb3c6aeb3)
[4294787.218000] EIP is at bttv_risc_packed+0x1b8/0x1e0 [bttv]
[4294787.218000] eax: 14000008   ebx: 00000408   ecx: d0337000   edx: d0f15800
[4294787.218000] esi: 00000008   edi: d0f15800   ebp: d11e4e6c   esp: d11e4e30
[4294787.218000] ds: 007b   es: 007b   ss: 0068
[4294787.218000] Process xawtv (pid: 7277, threadinfo=d11e4000 task=d85f1ab0)
[4294787.218000] Stack: e0b55b00 d0336000 00000fd0 00000c00 00000120 000001fa 00000ff8 d0f14000
[4294787.218000]        d0178fbc e0b62860 000000ff d0336ff8 000d8000 00000c00 d0178ef8 d11e4ed4
[4294787.218000]        e0b5013a 00000c00 00000c00 00000c00 00000120 00000008 000001b1 d0178f1c
[4294787.218000] Call Trace:
[4294787.218000]  [<c01039b7>] show_stack+0x97/0xd0
[4294787.218000]  [<c0103b65>] show_registers+0x155/0x1f0
[4294787.218000]  [<c0103d82>] die+0xe2/0x170
[4294787.218000]  [<c02c8d9c>] do_page_fault+0x1ec/0x648
[4294787.218000]  [<c0103653>] error_code+0x4f/0x54
[4294787.218000]  [<e0b5013a>] bttv_buffer_risc+0x61a/0x640 [bttv]
[4294787.218000]  [<e0b457bb>] bttv_prepare_buffer+0xab/0x1a0 [bttv]
[4294787.218000]  [<e0b45958>] buffer_prepare+0x38/0x40 [bttv]
[4294787.218000]  [<e0a2b393>] videobuf_read_zerocopy+0x63/0x110 [video_buf]
[4294787.218000]  [<e0a2b5f4>] videobuf_read_one+0x1b4/0x210 [video_buf]
[4294787.218000]  [<e0b48625>] bttv_read+0x115/0x120 [bttv]
[4294787.218000]  [<c01555c3>] vfs_read+0x93/0x150
[4294787.218000]  [<c015592d>] sys_read+0x3d/0x70
[4294787.218000]  [<c0102b3f>] sysenter_past_esp+0x54/0x75
[4294787.218000] Code: 2c 89 f6 0d 00 00 00 10 89 01 8b 42 08 89 41 04 2b 72 0c 83 c1 08 8b 03 83 c2 10 83 c3 10 39 c6 77 e1 89 f0 89 d7 0d 00 00 00 14 <89> 01 8b 42 08
 89 41 04 83 c1 08 89 f0 89 4d f0 e9 4f ff ff ff

bttv_risc_packed writes off the end of the risc->cpu buffer.  The problem is
that the length of the buffer is calculated wrongly.  The allocated size was
4048 bytes, but bttv_risc_packed wrote more than one page (the oops occurred
when it started over-writing the next page).  The length is instructions*8:

int
bttv_risc_packed(struct bttv *btv, struct btcx_riscmem *risc,
                 struct scatterlist *sglist,
                 unsigned int offset, unsigned int bpl,
                 unsigned int padding, unsigned int lines)
{
        u32 instructions,line,todo;
        struct scatterlist *sg;
        u32 *rp;
        int rc;

        /* estimate risc mem: worst case is one write per page border +
           one write per scan line + sync + jump (all 2 dwords) */
        instructions  = (bpl * lines) / PAGE_SIZE + lines;
        instructions += 2;
        if ((rc = btcx_riscmem_alloc(btv->c.pci,risc,instructions*8)) < 0)
                return rc;

But "instructions" is calculated wrong.  First of all, notice the division by
PAGE_SIZE?

        instructions  = (bpl * lines) / PAGE_SIZE + lines;

If sg_dma_len(sg) was constant (and bpl > 0), then a correct estimate seems
to be:

	instructions = (1 + (bpl - 1) / sg_dma_len(sg)) * lines - 1 + lines;
        instructions += 2;

Unfortunately sg is modified during the action of bttv_risc_packed, so I
guess sg_dma_len(sg) cannot be assumed to be constant.  Presumably PAGE_SIZE
is used because it is supposed to be a lower bound for sg_dma_len(sg).  Well,
this is wrong: for example when my oops occurs, the parameters are:

bpl: 3072; lines: 288; instructions: 506; sg_dma_len: 4088

and here sg_dma_len < PAGE_SIZE (this is the size of the first element in
sglist).  This is not however the cause of my oops: because bpl is smaller
than sg_dma_len(sg) and smaller than PAGE_SIZE, this error makes no difference
in the calculation of the buffer size.  It should be fixed of course, but if
sg_dma_len(sg) can be less than PAGE_SIZE, it is not clear to me how to fix it.

The other mistake in the buffer size calculation, and the one that hits me, is
that 2 * lines should be added, not lines: assuming that sg_dma_len(sg) >= PAGE_SIZE,
it looks to me like the calculation should be

        instructions  = (bpl * lines) / PAGE_SIZE + 2 * lines;
        instructions += 1;

The reason is that at least two instructions are written for every line in the case
when the scanline needs to be split:

                } else {
                        /* scanline needs to be splitted */
                        todo = bpl;
                        *(rp++)=cpu_to_le32(BT848_RISC_WRITE|BT848_RISC_SOL|
                                            (sg_dma_len(sg)-offset));
                        *(rp++)=cpu_to_le32(sg_dma_address(sg)+offset);
                        todo -= (sg_dma_len(sg)-offset);
                        offset = 0;
                        sg++;
                        while (todo > sg_dma_len(sg)) {
                                *(rp++)=cpu_to_le32(BT848_RISC_WRITE|
                                                    sg_dma_len(sg));
                                *(rp++)=cpu_to_le32(sg_dma_address(sg));
                                todo -= sg_dma_len(sg);
                                sg++;
                        }
                        *(rp++)=cpu_to_le32(BT848_RISC_WRITE|BT848_RISC_EOL|
                                            todo);
                        *(rp++)=cpu_to_le32(sg_dma_address(sg));
                        offset += todo;
                }

This means that instructions needs to be at least 2 * lines.

Of course it is possible that my estimate for instructions could be tightened.

Comments?

All the best,

Duncan.
